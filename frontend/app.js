// DATOS DE EJEMPLO (MOCK) — reemplazar por fetch() al backend cuando exista pls
const RAZAS = [
  "Labrador", "Pastor Alemán", "Chihuahua", "Pitbull", "Schnauzer",
  "Poodle", "Xoloitzcuintle", "Husky Siberiano", "Bulldog Francés", "Beagle"
];

const COLORES = [
  "Negro", "Blanco", "Café", "Dorado", "Gris",
  "Atigrado", "Manchado", "Crema", "Rojizo", "Negro y blanco"
];

let PERRITOS = [
  {
    id: "mock-1",
    nombre: "Canela",
    raza: "Xoloitzcuintle",
    colorPrincipal: "Café",
    coloresAdicionales: ["Blanco"],
    lat: 25.4383, lng: -100.9737,
    foto: null,
    fecha: "2026-09-20T10:00:00"
  },
  {
    id: "mock-2",
    nombre: "Rocky",
    raza: "Pastor Alemán",
    colorPrincipal: "Negro",
    coloresAdicionales: ["Café"],
    lat: 25.4295, lng: -100.9855,
    foto: null,
    fecha: "2026-09-21T15:30:00"
  }
];

// inicializar — catálogos
function llenarSelect(select, opciones) {
  opciones.forEach(op => {
    const el = document.createElement("option");
    el.value = op;
    el.textContent = op;
    select.appendChild(el);
  });
}

llenarSelect(document.getElementById("raza"), RAZAS);
llenarSelect(document.getElementById("color-principal"), COLORES);
llenarSelect(document.getElementById("color-extra-1"), COLORES);
llenarSelect(document.getElementById("color-extra-2"), COLORES);

// pestañas
const tabs = document.querySelectorAll(".tab");
const views = document.querySelectorAll(".view");

function irAVista(nombre) {
  tabs.forEach(t => t.classList.toggle("active", t.dataset.view === nombre));
  views.forEach(v => v.classList.toggle("active", v.id === "view-" + nombre));
  if (nombre === "map") setTimeout(() => fullMap.invalidateSize(), 50);
  if (nombre === "list") renderizarLista();
}

tabs.forEach(t => t.addEventListener("click", () => irAVista(t.dataset.view)));
document.getElementById("back-to-list").addEventListener("click", () => irAVista("list"));

// MAPAS (usando API gratuita de leaflet y OpenStreetMap)
const SALTILLO = [25.4260, -101.0053];

const formMap = L.map("form-map").setView(SALTILLO, 13);
L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution: "&copy; OpenStreetMap"
}).addTo(formMap);

let formMarker = null;
let ubicacionSeleccionada = null;

function colocarPin(lat, lng) {
  ubicacionSeleccionada = { lat, lng };
  if (formMarker) {
    formMarker.setLatLng([lat, lng]);
  } else {
    formMarker = L.marker([lat, lng], { draggable: true }).addTo(formMap);
    formMarker.on("dragend", () => {
      const pos = formMarker.getLatLng();
      ubicacionSeleccionada = { lat: pos.lat, lng: pos.lng };
      actualizarCoordsLabel();
    });
  }
  formMap.setView([lat, lng], 15);
  actualizarCoordsLabel();
}

function actualizarCoordsLabel() {
  const label = document.getElementById("coords-label");
  if (!ubicacionSeleccionada) { label.textContent = "Sin ubicación"; return; }
  label.textContent = `${ubicacionSeleccionada.lat.toFixed(5)}, ${ubicacionSeleccionada.lng.toFixed(5)}`;
}

formMap.on("click", e => colocarPin(e.latlng.lat, e.latlng.lng));

document.getElementById("btn-mi-ubicacion").addEventListener("click", () => {
  if (!navigator.geolocation) {
    alert("Tu navegador no soporta geolocalización.");
    return;
  }
  navigator.geolocation.getCurrentPosition(
    pos => colocarPin(pos.coords.latitude, pos.coords.longitude),
    () => alert("No se pudo obtener tu ubicación. Puedes poner el pin a mano tocando el mapa.")
  );
});

const fullMap = L.map("full-map").setView(SALTILLO, 12);
L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution: "&copy; OpenStreetMap"
}).addTo(fullMap);

function renderizarMapaCompleto() {
  fullMap.eachLayer(layer => {
    if (layer instanceof L.Marker) fullMap.removeLayer(layer);
  });
  PERRITOS.forEach(p => {
    const marker = L.marker([p.lat, p.lng]).addTo(fullMap);
    const colores = [p.colorPrincipal, ...p.coloresAdicionales].join(", ");
    marker.bindPopup(`<strong>${escapeHtml(p.nombre)}</strong><br>${escapeHtml(colores)}`);
  });
}
renderizarMapaCompleto();

// foto del cachou feliz

let fotoDataUrl = null;

function manejarFoto(input) {
  const file = input.files[0];
  if (!file) return;
  if (!file.type.startsWith("image/")) {
    mostrarError("foto", "El archivo debe ser una imagen.");
    return;
  }
  const reader = new FileReader();
  reader.onload = e => {
    fotoDataUrl = e.target.result;
    const preview = document.getElementById("foto-preview");
    preview.src = fotoDataUrl;
    preview.hidden = false;
    mostrarError("foto", "");
  };
  reader.readAsDataURL(file);
}

document.getElementById("foto-camara").addEventListener("change", e => manejarFoto(e.target));
document.getElementById("foto-archivo").addEventListener("change", e => manejarFoto(e.target));

// validacion de formulario
function mostrarError(campo, mensaje) {
  const el = document.querySelector(`.error[data-for="${campo}"]`);
  if (el) el.textContent = mensaje;
}

function limpiarErrores() {
  document.querySelectorAll(".error").forEach(e => e.textContent = "");
}

function validarFormulario() {
  limpiarErrores();
  let valido = true;

  const nombre = document.getElementById("nombre").value.trim();
  if (!nombre) {
    mostrarError("nombre", "El nombre no puede estar vacío.");
    valido = false;
  }

  if (!fotoDataUrl) {
    mostrarError("foto", "Falta la foto.");
    valido = false;
  }

  const colorPrincipal = document.getElementById("color-principal").value;
  if (!colorPrincipal) {
    mostrarError("color-principal", "Elige un color principal.");
    valido = false;
  }

  const extra1 = document.getElementById("color-extra-1").value;
  const extra2 = document.getElementById("color-extra-2").value;
  const extras = [extra1, extra2].filter(Boolean);
  const todos = [colorPrincipal, ...extras].filter(Boolean);
  const sinDuplicados = new Set(todos).size === todos.length;
  if (!sinDuplicados) {
    mostrarError("colores", "No repitas un color entre el principal y los adicionales.");
    valido = false;
  }
  if (todos.length > 3) {
    mostrarError("colores", "Máximo 3 colores en total.");
    valido = false;
  }

  if (!ubicacionSeleccionada) {
    mostrarError("ubicacion", "Marca un punto en el mapa o usa tu ubicación.");
    valido = false;
  }

  return valido;
}

// IDEMPOTENCIA: Se genera UNA vez al cargar el formulario.
// si el usuario envía dos veces, se manda la misma clave
// y el backend debe devolver el mismo registro sin duplicar

let idempotencyKey = crypto.randomUUID();

// submit del formulario
document.getElementById("dog-form").addEventListener("submit", async e => {
  e.preventDefault();
  const status = document.getElementById("form-status");
  status.textContent = "";
  status.className = "form-status";

  if (!validarFormulario()) {
    status.textContent = "Revisa los campos marcados arriba.";
    status.classList.add("err");
    return;
  }

  const registro = {
    idempotencyKey,
    nombre: document.getElementById("nombre").value.trim(),
    raza: document.getElementById("raza").value || null,
    colorPrincipal: document.getElementById("color-principal").value,
    coloresAdicionales: [document.getElementById("color-extra-1").value, document.getElementById("color-extra-2").value].filter(Boolean),
    lat: ubicacionSeleccionada.lat,
    lng: ubicacionSeleccionada.lng,
    foto: fotoDataUrl
  };

  // reemplazar este bloque por fetch() al backend cuando exista xfavor
  // const res = await fetch("/api/perritos", {
  //   method: "POST",
  //   headers: { "Content-Type": "application/json" },
  //   body: JSON.stringify(registro)
  // });
  // const data = await res.json();

  PERRITOS.push({
    id: registro.idempotencyKey,
    nombre: registro.nombre,
    raza: registro.raza,
    colorPrincipal: registro.colorPrincipal,
    coloresAdicionales: registro.coloresAdicionales,
    lat: registro.lat,
    lng: registro.lng,
    foto: registro.foto,
    fecha: new Date().toISOString()
  });

  status.textContent = `${registro.nombre} fue registrado correctamente.`;
  status.classList.add("ok");

  e.target.reset();
  fotoDataUrl = null;
  document.getElementById("foto-preview").hidden = true;
  ubicacionSeleccionada = null;
  if (formMarker) { formMap.removeLayer(formMarker); formMarker = null; }
  actualizarCoordsLabel();
  idempotencyKey = crypto.randomUUID(); // nueva clave para el siguiente registro
  renderizarMapaCompleto();
});

// lista y detalle
function escapeHtml(str) {
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

function renderizarLista() {
  const ul = document.getElementById("dog-list");
  ul.innerHTML = "";

  if (PERRITOS.length === 0) {
    ul.innerHTML = `<li class="empty-state">Todavía no hay perritos registrados. Sé el primero en reportar uno.</li>`;
    return;
  }

  PERRITOS.forEach(p => {
    const li = document.createElement("li");
    li.innerHTML = `
      <img src="${p.foto || ''}" alt="" onerror="this.style.background='var(--line)'" />
      <div>
        <div class="li-name">${escapeHtml(p.nombre)}</div>
        <div class="li-colors">${escapeHtml([p.colorPrincipal, ...p.coloresAdicionales].join(", "))}</div>
      </div>
    `;
    li.addEventListener("click", () => mostrarDetalle(p.id));
    ul.appendChild(li);
  });
}

// guarda cuál perrito se está viendo en detalle, para que el botón
// de eliminar sepa a cuál le toca sin tener que rearmar el HTML
let currentDetailId = null;

function mostrarDetalle(id) {
  currentDetailId = id;
  const p = PERRITOS.find(x => x.id === id);
  if (!p) return;
  const cont = document.getElementById("detail-content");
  cont.innerHTML = `
    ${p.foto ? `<img src="${p.foto}" alt="Foto de ${escapeHtml(p.nombre)}" />` : ""}
    <h2>${escapeHtml(p.nombre)}</h2>
    <p>${escapeHtml(p.raza || "Sin raza definida / criollo")}</p>
    <div class="tag-row">
      <span class="tag">${escapeHtml(p.colorPrincipal)}</span>
      ${p.coloresAdicionales.map(c => `<span class="tag">${escapeHtml(c)}</span>`).join("")}
    </div>
    <p class="hint">Visto el ${new Date(p.fecha).toLocaleDateString("es-MX", { day: "numeric", month: "long", year: "numeric" })}</p>
  `;
  irAVista("detail");
}

// ELIMINAR
// por ahora solo quita del arreglo PERRITOS en memoria.

// cuando exista el backend, aquí va:
// await fetch(`/api/perritos/${currentDetailId}`, { method: "DELETE" });
document.getElementById("btn-eliminar").addEventListener("click", () => {
  if (!currentDetailId) return;
  const p = PERRITOS.find(x => x.id === currentDetailId);
  if (!p) return;

  const confirmado = confirm(`¿Eliminar el registro de ${p.nombre}? No se puede deshacer.`);
  if (!confirmado) return;

  PERRITOS = PERRITOS.filter(x => x.id !== currentDetailId);
  currentDetailId = null;
  renderizarMapaCompleto();
  irAVista("list");
});