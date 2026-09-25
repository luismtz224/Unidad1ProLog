// dirección del backend (FastAPI). si el servidor cambia de puerto o de
// máquina, solo se cambia aquí y todos los fetch() lo siguen
const API_BASE = "http://localhost:8000";
const API_URL = `${API_BASE}/api`;

// CATÁLOGOS — copia de lo que hay en las tablas raza y color de la base de datos.
// si se agrega o cambia una raza o un color en la base, hay que cambiarlo aquí también.
// los nombres son los mismos que el catálogo de la tabla raza en la base de datos.
// "Sin raza definida / criollo" no va aquí porque ya es la opción vacía del select
const RAZAS = [
  "Labrador Retriever", "Pastor Alemán", "Chihuahua", "Xoloitzcuintle", "Schnauzer",
  "Pitbull / Terrier americano", "Husky Siberiano", "Salchicha (Dachshund)",
  "Poodle / Caniche", "Border Collie"
];

// cada color trae su hex real para pintar los círculos de las fichas.
// los nombres son los mismos que el catálogo de la tabla color en la base de datos
const COLORES = [
  { nombre: "Negro", hex: "#2b2623" },
  { nombre: "Blanco", hex: "#fbf8f2" },
  { nombre: "Café", hex: "#7b4b2a" },
  { nombre: "Dorado", hex: "#d6a24a" },
  { nombre: "Gris", hex: "#9b958c" },
  { nombre: "Atigrado", hex: "repeating-linear-gradient(45deg,#7b4b2a 0 4px,#2b2623 4px 8px)" },
  { nombre: "Manchado", hex: "radial-gradient(circle at 32% 34%,#2b2623 0 22%,transparent 23%),radial-gradient(circle at 70% 70%,#2b2623 0 17%,transparent 18%),#fbf8f2" },
  { nombre: "Crema", hex: "#ecd8b2" },
  { nombre: "Rojizo", hex: "#b0522a" },
  { nombre: "Canela", hex: "#b8763a" }
];
const HEX_POR_COLOR = Object.fromEntries(COLORES.map(c => [c.nombre, c.hex]));

// declarada arriba de todo porque varias funciones (la vista previa,
// la validación, el manejo de la cámara) la leen desde el principio
let fotoDataUrl = null;

// tintes de fondo para la foto cuando el perrito no tiene una — se
// eligen recorriendo este arreglo, no al azar, para que la misma
// tarjeta no cambie de color cada vez que se vuelve a dibujar
const TINTES = [
  { bg: "#e1eecc", ink: "#56633f" },
  { bg: "#ffdccb", ink: "#953014" },
  { bg: "#ddd5c4", ink: "#474138" }
];

let PERRITOS = [];

// fecha relativa tipo "hace 2 días" para las fichas y el detalle
function cuando(iso) {
  const dias = Math.floor((Date.now() - new Date(iso).getTime()) / 86400000);
  if (dias <= 0) return "hoy";
  if (dias === 1) return "ayer";
  if (dias < 7) return `hace ${dias} días`;
  return "el " + new Date(iso).toLocaleDateString("es-MX", { day: "numeric", month: "short" });
}

// texto de la raza para mostrar en pantalla. en la base hay dos formas de
// decir "sin raza": la raza queda en NULL (lo que guarda el formulario) o es
// el renglón "Sin raza definida / criollo" del catálogo (lo que traen los
// perritos de prueba). aquí las dos se ven igual
function textoRaza(raza) {
  if (!raza || raza === "Sin raza definida / criollo") return "Sin raza definida";
  return raza;
}

// tinte determinístico por id, así la misma ficha siempre sale del
// mismo color aunque se vuelva a dibujar la lista
function tintePara(id) {
  const suma = [...String(id)].reduce((acc, ch) => acc + ch.charCodeAt(0), 0);
  return TINTES[suma % TINTES.length];
}

function escapeHtml(str) {
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

// ============================================================
// MODO OSCURO / CLARO
// ============================================================
// La preferencia elegida a mano (botón) manda sobre la del sistema.
// Sin elección guardada, se usa lo que diga prefers-color-scheme.
const CLAVE_TEMA = "perritos-tema";

function temaEfectivo() {
  const guardado = localStorage.getItem(CLAVE_TEMA);
  if (guardado === "light" || guardado === "dark") return guardado;
  return window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
}

function aplicarTema(tema) {
  document.documentElement.setAttribute("data-theme", tema);
}

aplicarTema(temaEfectivo());

document.getElementById("theme-toggle").addEventListener("click", () => {
  const nuevo = temaEfectivo() === "dark" ? "light" : "dark";
  localStorage.setItem(CLAVE_TEMA, nuevo);
  aplicarTema(nuevo);
});

// ============================================================
// CINTA "¿LO HAS VISTO?"
// ============================================================
// nombres generados con .map() a partir de PERRITOS (transformación
// funcional, no imperativa con for/ciclos). Se repite el arreglo dos
// veces para que la animación de scroll se vea continua sin salto.
function renderizarTicker() {
  const track = document.getElementById("ticker-track");
  const nombres = PERRITOS.map(p => p.nombre);

  const itemsHtml = nombres
    .map(nombre => `
      <span class="ticker-item">${escapeHtml(nombre)}</span>
      <span class="ticker-item pregunta">¿Lo has visto?<span class="dot"></span></span>
    `)
    .join("");

  track.innerHTML = itemsHtml + itemsHtml;
}

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
renderizarTicker();

// ============================================================
// COLORES DEL FORMULARIO — botones tipo "swatch"
// ============================================================
// coloresElegidos guarda el orden de selección: el primero es
// siempre el color principal, los demás son adicionales (máx 3).
let coloresElegidos = [];

function toggleColor(nombre) {
  const idx = coloresElegidos.indexOf(nombre);
  if (idx >= 0) {
    coloresElegidos.splice(idx, 1);
  } else if (coloresElegidos.length < 3) {
    coloresElegidos.push(nombre);
  }
  renderizarSwatches();
  actualizarPreview();
}

function renderizarSwatches() {
  const cont = document.getElementById("color-swatches");
  cont.innerHTML = COLORES.map(c => {
    const idx = coloresElegidos.indexOf(c.nombre);
    const clase = idx === 0 ? "picked-principal" : idx > 0 ? "picked-extra" : "";
    const tagPrincipal = idx === 0 ? `<span class="swatch-tag">principal</span>` : "";
    return `
      <button type="button" class="swatch-btn ${clase}" data-color="${escapeHtml(c.nombre)}">
        <span class="swatch-dot" style="background:${c.hex}"></span>
        ${escapeHtml(c.nombre)}
        ${tagPrincipal}
      </button>
    `;
  }).join("");

  cont.querySelectorAll(".swatch-btn").forEach(btn => {
    btn.addEventListener("click", () => toggleColor(btn.dataset.color));
  });
}
renderizarSwatches();

// ============================================================
// VISTA PREVIA EN VIVO (solo se ve en pantallas anchas)
// ============================================================
function actualizarPreview() {
  const nombreVal = document.getElementById("nombre").value.trim();
  document.getElementById("preview-name").textContent = nombreVal || "Aún sin nombre";

  const razaVal = document.getElementById("raza").value;
  document.getElementById("preview-breed").textContent = textoRaza(razaVal);

  const fotoCont = document.getElementById("preview-photo");
  if (fotoDataUrl) {
    fotoCont.innerHTML = `<img src="${fotoDataUrl}" alt="" />`;
  } else if (nombreVal) {
    fotoCont.innerHTML = `<span class="initial">${escapeHtml(nombreVal[0].toUpperCase())}</span>`;
  } else {
    fotoCont.innerHTML = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3z"/><circle cx="12" cy="13" r="3"/></svg>`;
  }

  document.getElementById("preview-colors").innerHTML = coloresElegidos
    .map(c => `<span style="background:${HEX_POR_COLOR[c] || '#ccc'}"></span>`)
    .join("");
}

document.getElementById("nombre").addEventListener("input", actualizarPreview);
document.getElementById("raza").addEventListener("change", actualizarPreview);
actualizarPreview();

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
  // las llaves se llaman igual que las columnas de la tabla perrito (latitud y longitud)
  ubicacionSeleccionada = { latitud: lat, longitud: lng };
  if (formMarker) {
    formMarker.setLatLng([lat, lng]);
  } else {
    formMarker = L.marker([lat, lng], { draggable: true }).addTo(formMap);
    formMarker.on("dragend", () => {
      const pos = formMarker.getLatLng();
      ubicacionSeleccionada = { latitud: pos.lat, longitud: pos.lng };
      actualizarCoordsLabel();
    });
  }
  formMap.setView([lat, lng], 15);
  actualizarCoordsLabel();
}

function actualizarCoordsLabel() {
  const label = document.getElementById("coords-label");
  if (!ubicacionSeleccionada) { label.textContent = "Sin ubicación"; return; }
  label.textContent = `${ubicacionSeleccionada.latitud.toFixed(5)}, ${ubicacionSeleccionada.longitud.toFixed(5)}`;
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
    const marker = L.marker([p.latitud, p.longitud]).addTo(fullMap);
    const colores = [p.colorPrincipal, ...p.coloresAdicionales].join(", ");
    marker.bindPopup(`<strong>${escapeHtml(p.nombre)}</strong><br>${escapeHtml(colores)}`);
  });
}
renderizarMapaCompleto();

// ============================================================
// FOTO — subir de galería
// ============================================================
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
    actualizarPreview();
  };
  reader.readAsDataURL(file);
}

document.getElementById("foto-archivo").addEventListener("change", e => manejarFoto(e.target));
document.getElementById("foto-camara-fallback").addEventListener("change", e => manejarFoto(e.target));

// ============================================================
// FOTO — cámara en vivo con getUserMedia()
// ============================================================
// A diferencia de un <input capture> suelto (que en laptop solo abre
// el explorador de archivos, nunca la webcam), esto sí pide permiso
// de cámara de verdad — funciona igual en laptop que en celular. Si
// el navegador no lo soporta o el usuario niega el permiso, cae al
// input de archivo de respaldo (que en celular sigue abriendo la
// cámara nativa del sistema).
const dialogCamara = document.getElementById("dialog-camara");
const cameraVideo = document.getElementById("camera-video");
const cameraError = document.getElementById("camera-error");
let cameraStream = null;

async function abrirCamara() {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    document.getElementById("foto-camara-fallback").click();
    return;
  }

  dialogCamara.hidden = false;
  cameraError.hidden = true;
  cameraError.innerHTML = "";

  try {
    cameraStream = await navigator.mediaDevices.getUserMedia({
      video: { facingMode: { ideal: "environment" } },
      audio: false
    });
    cameraVideo.srcObject = cameraStream;
  } catch (err) {
    cameraError.hidden = false;
    cameraError.innerHTML = `
      <span>No pudimos abrir la cámara. Revisa los permisos del navegador o usa la del sistema.</span>
      <button type="button" class="photo-btn" id="camera-usar-sistema">Abrir cámara del sistema</button>
    `;
    document.getElementById("camera-usar-sistema").addEventListener("click", () => {
      cerrarCamara();
      document.getElementById("foto-camara-fallback").click();
    });
  }
}

function cerrarCamara() {
  if (cameraStream) {
    cameraStream.getTracks().forEach(track => track.stop());
    cameraStream = null;
  }
  cameraVideo.srcObject = null;
  dialogCamara.hidden = true;
}

function capturarFoto() {
  if (!cameraVideo.videoWidth) return; // el video aún no está listo
  const maxAncho = 1100;
  const escala = Math.min(1, maxAncho / Math.max(cameraVideo.videoWidth, cameraVideo.videoHeight));
  const canvas = document.createElement("canvas");
  canvas.width = Math.round(cameraVideo.videoWidth * escala);
  canvas.height = Math.round(cameraVideo.videoHeight * escala);
  canvas.getContext("2d").drawImage(cameraVideo, 0, 0, canvas.width, canvas.height);

  fotoDataUrl = canvas.toDataURL("image/jpeg", 0.85);
  const preview = document.getElementById("foto-preview");
  preview.src = fotoDataUrl;
  preview.hidden = false;
  mostrarError("foto", "");
  actualizarPreview();
  cerrarCamara();
}

document.getElementById("btn-tomar-foto").addEventListener("click", abrirCamara);
document.getElementById("camera-cancelar").addEventListener("click", cerrarCamara);
document.getElementById("camera-capturar").addEventListener("click", capturarFoto);
dialogCamara.addEventListener("click", e => { if (e.target === dialogCamara) cerrarCamara(); });

// ============================================================
// VALIDACIÓN DE FORMULARIO
// ============================================================
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

  if (coloresElegidos.length === 0) {
    mostrarError("colores", "Elige al menos un color (el primero que toques es el principal).");
    valido = false;
  }
  // no hace falta checar duplicados ni el máximo de 3: toggleColor()
  // ya lo impide desde la interfaz

  if (!ubicacionSeleccionada) {
    mostrarError("ubicacion", "Marca un punto en el mapa o usa tu ubicación.");
    valido = false;
  }

  return valido;
}

// IDEMPOTENCIA: Se genera UNA vez al cargar el formulario.
// si el usuario envía dos veces, se manda la misma clave
// y el backend debe devolver el mismo registro sin duplicar
let claveIdempotencia = crypto.randomUUID();

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

  // las llaves clave_idempotencia, nombre, latitud y longitud se llaman igual
  // que las columnas de la tabla perrito. raza y colores se mandan con su
  // nombre; el backend se encarga de buscar los ids (raza_id, color_id).
  // fecha_registro y el id no se mandan: los pone la base de datos sola
  const registro = {
    clave_idempotencia: claveIdempotencia,
    nombre: document.getElementById("nombre").value.trim(),
    raza: document.getElementById("raza").value || null,
    colorPrincipal: coloresElegidos[0],
    coloresAdicionales: coloresElegidos.slice(1),
    latitud: ubicacionSeleccionada.latitud,
    longitud: ubicacionSeleccionada.longitud,
    foto: fotoDataUrl
  };

  // la ruta del backend termina en "/" (/api/perritos/). sin esa barra
  // FastAPI responde con una redirección 307 en lugar de atender la petición
  let res;
  try {
    res = await fetch(`${API_URL}/perritos/`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(registro)
    });
  } catch (err) {
    // fetch solo lanza error cuando ni siquiera pudo llegar al servidor
    // (backend apagado, sin red, CORS bloqueado). la clave de idempotencia
    // no se cambia, así el usuario puede reintentar con el mismo registro
    console.error("No se pudo conectar con el backend:", err);
    status.textContent = "No hay conexión con el servidor. Intenta de nuevo en un momento.";
    status.classList.add("err");
    return;
  }

  if (!res.ok) {
    const error = await res.json().catch(() => ({}));
    // el backend manda "detail" de dos formas: en los errores 400 es un
    // texto listo para mostrar, pero en los 422 (datos que no cumplen el
    // esquema) es una lista de objetos y se vería como [object Object]
    if (typeof error.detail === "string") {
      status.textContent = error.detail;
    } else if (Array.isArray(error.detail)) {
      status.textContent = "Los datos del formulario no son válidos. Revísalos e intenta de nuevo.";
    } else {
      status.textContent = "No se pudo registrar. Intenta de nuevo.";
    }
    status.classList.add("err");
    return;
  }

  // en vez de agregar el perrito a mano en el arreglo, se vuelve a pedir la
  // lista completa al backend: así el orden (lo más nuevo primero) y los datos
  // son siempre los de la base, y si la clave de idempotencia ya existía
  // no queda el mismo perrito repetido en pantalla.
  // cargarPerritos() también vuelve a dibujar la lista, el mapa y el ticker
  await cargarPerritos();

  status.textContent = `${registro.nombre} fue registrado correctamente.`;
  status.classList.add("ok");

  e.target.reset();
  fotoDataUrl = null;
  document.getElementById("foto-preview").hidden = true;
  coloresElegidos = [];
  renderizarSwatches();
  ubicacionSeleccionada = null;
  if (formMarker) { formMap.removeLayer(formMarker); formMarker = null; }
  actualizarCoordsLabel();
  actualizarPreview();
  claveIdempotencia = crypto.randomUUID(); // nueva clave para el siguiente registro
});

// LISTA Y DETALLE

// pide la lista de perritos al backend y redibuja lista, mapa y ticker.
// se llama al abrir la página y después de registrar un perrito
async function cargarPerritos() {
  try {
    const res = await fetch(`${API_URL}/perritos/`);

    if (!res.ok) {
      throw new Error(`HTTP ${res.status}`);
    }

    PERRITOS = await res.json();

    renderizarLista();
    renderizarMapaCompleto();
    renderizarTicker();
  } catch (error) {
    console.error("Error al cargar los perritos:", error);

    const ul = document.getElementById("dog-list");
    ul.innerHTML = `<li class="empty-state">No se pudieron cargar los perritos registrados.</li>`;
  }
}

function getFotoUrl(foto) {
  if (!foto) return "";
  if (foto.startsWith("data:") || foto.startsWith("http")) return foto;
  // el backend manda la ruta relativa ("/api/imagenes/xxx.jpg"), aquí se
  // le pega la dirección del servidor para que el <img> la pueda cargar
  return API_BASE + foto;
}

function renderizarLista() {
  const ul = document.getElementById("dog-list");
  ul.innerHTML = "";

  if (PERRITOS.length === 0) {
    ul.innerHTML = `<li class="empty-state">Todavía no hay perritos registrados. Sé el primero en reportar uno.</li>`;
    return;
  }

  PERRITOS.forEach((p, i) => {
    const tinte = tintePara(p.id);
    const inclinacion = (i % 2 === 0 ? -1 : 1) * (1 + (i % 3));
    const li = document.createElement("li");
    li.className = "dog-card";
    li.style.setProperty("--tilt", `${inclinacion}deg`);
    li.style.setProperty("--tint-bg", tinte.bg);
    li.style.setProperty("--tint-ink", tinte.ink);
    li.innerHTML = `
      <div class="dog-photo">
        ${p.foto
          ? `<img src="${getFotoUrl(p.foto)}" alt="" />`
          : `<span class="initial">${escapeHtml(p.nombre[0]?.toUpperCase() || "?")}</span>`}
        <span class="seen-tag">Visto ${cuando(p.fecha_registro)}</span>
      </div>
      <div class="dog-card-body">
        <div class="name">${escapeHtml(p.nombre)}</div>
        <div class="breed">${escapeHtml(textoRaza(p.raza))}</div>
        <div class="dot-row">
          ${[p.colorPrincipal, ...p.coloresAdicionales].map(c => `<span style="background:${HEX_POR_COLOR[c] || '#ccc'}"></span>`).join("")}
        </div>
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
  const tinte = tintePara(p.id);
  const cont = document.getElementById("detail-content");
  cont.innerHTML = `
    <div class="detail-photo" style="--tint-bg:${tinte.bg};--tint-ink:${tinte.ink}">
      ${p.foto
        ? `<img src="${getFotoUrl(p.foto)}" alt="Foto de ${escapeHtml(p.nombre)}" />`
        : `<span class="initial">${escapeHtml(p.nombre[0]?.toUpperCase() || "?")}</span>`}
    </div>
    <h2>${escapeHtml(p.nombre)}</h2>
    <p class="breed">${escapeHtml(textoRaza(p.raza))}</p>
    <div class="tag-row">
      ${[p.colorPrincipal, ...p.coloresAdicionales].map(c => `
        <span class="tag"><span class="swatch-dot" style="background:${HEX_POR_COLOR[c] || '#ccc'}"></span>${escapeHtml(c)}</span>
      `).join("")}
    </div>
    <p class="hint" style="margin-top:16px">Visto ${cuando(p.fecha_registro)}</p>
  `;
  irAVista("detail");
}

// ELIMINAR — usa un diálogo propio en vez de confirm() del navegador.
// al confirmar se manda DELETE al backend y, si sale bien, se quita del arreglo PERRITOS
const dialogEliminar = document.getElementById("dialog-eliminar");

document.getElementById("btn-eliminar").addEventListener("click", () => {
  if (!currentDetailId) return;
  const p = PERRITOS.find(x => x.id === currentDetailId);
  if (!p) return;
  document.getElementById("dialog-eliminar-titulo").textContent = `¿Eliminar el registro de ${p.nombre}?`;
  dialogEliminar.hidden = false;
});

document.getElementById("dialog-cancelar").addEventListener("click", () => {
  dialogEliminar.hidden = true;
});

document.getElementById("dialog-confirmar").addEventListener("click", async () => {
  try {
    const res = await fetch(`${API_URL}/perritos/${currentDetailId}`, { method: "DELETE" });
    if (!res.ok) throw new Error("No se pudo eliminar");

    PERRITOS = PERRITOS.filter(x => x.id !== currentDetailId);
    currentDetailId = null;
    dialogEliminar.hidden = true;
    renderizarMapaCompleto();
    renderizarTicker();
    irAVista("list");
  } catch (error) {
    console.error(error);
    alert("Hubo un error al eliminar.");
  }
});

dialogEliminar.addEventListener("click", e => {
  if (e.target === dialogEliminar) dialogEliminar.hidden = true;
});

cargarPerritos();