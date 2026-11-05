// ============================================================
// ESTADÍSTICAS (P2 — servicio Elixir GET /f/estadisticas)
//
// Esta pantalla SOLO pinta. Todo el conteo (por color, raza y día,
// los más comunes) lo hace el núcleo de Elixir; aquí se pide el
// resumen y se dibujan barras.
//
// Se carga después de app.js y usa de ahí: FUNCIONAL_URL, HEX_POR_COLOR
// y crearNodo. No modifica app.js: la pestaña ya funciona porque
// irAVista() activa el elemento "view-" + data-view (view-stats).
//
// Respuesta del servicio:
//   { total: 135,
//     por_color: [{clave: "Negro", total: 40}, ...],
//     por_raza:  [{clave: "Chihuahua", total: 9}, ...],
//     por_dia:   [{clave: "2026-10-17", total: 2}, ...] }   // sólo días con avistamientos
// ============================================================

const MESES_CORTOS = ["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic"];
const MS_POR_DIA = 24 * 60 * 60 * 1000;

// "2026-10-17" -> milisegundos UTC (sin depender de la zona horaria del navegador)
function msDeClave(clave) {
  const [a, m, d] = clave.split("-").map(Number);
  return Date.UTC(a, m - 1, d);
}

function etiquetaDia(ms) {
  const f = new Date(ms);
  return `${f.getUTCDate()} ${MESES_CORTOS[f.getUTCMonth()]}`;
}

// El servicio sólo manda los días CON avistamientos. Para que la gráfica
// tenga un eje de tiempo continuo se rellenan con 0 los días intermedios
// (es presentación; el conteo ya viene hecho del servicio).
function diasContinuos(porDia) {
  if (porDia.length === 0) return [];
  const conteo = new Map(porDia.map(p => [msDeClave(p.clave), p.total]));
  const claves = [...conteo.keys()];
  const desde = Math.min(...claves);
  const hasta = Math.max(...claves);
  const dias = [];
  for (let ms = desde; ms <= hasta; ms += MS_POR_DIA) {
    dias.push({ ms, total: conteo.get(ms) || 0 });
  }
  return dias;
}

async function pedirEstadisticas(n) {
  let r;
  try {
    r = await fetch(`${FUNCIONAL_URL}/estadisticas?n=${n}`);
  } catch (e) {
    throw new Error("No se pudo conectar con el servicio Elixir (/f/estadisticas). Verifica que el contenedor funcional esté corriendo.");
  }
  if (r.status === 404) throw new Error("El servicio respondió 404: falta el forward de /f/estadisticas en el router o el proxy no manda /f/ al servicio Elixir.");
  if (r.status === 503) throw new Error("El servicio no pudo leer la base de datos (503).");
  if (!r.ok) throw new Error(`El servicio respondió ${r.status}.`);
  return r.json();
}

// una fila de barras: [muestra de color] etiqueta ▮▮▮▮ total
function filaBarra(item, maximo, esColor) {
  const porcentaje = maximo > 0 ? (item.total / maximo) * 100 : 0;
  const muestra = esColor
    ? crearNodo("span", { className: "stats-muestra" })
    : null;
  if (muestra) muestra.style.background = HEX_POR_COLOR[item.clave] || "#ccc";

  const relleno = crearNodo("span", { className: "stats-relleno" });
  relleno.style.width = `${porcentaje}%`;

  // sin muestra (razas) no se agrega ese hueco: crearNodo lo escribiría como el texto "null"
  const contenidoEtiqueta = muestra ? [muestra, item.clave] : [item.clave];

  return crearNodo("li", { className: "stats-fila" },
    crearNodo("span", { className: "stats-etiqueta" }, contenidoEtiqueta),
    crearNodo("span", { className: "stats-pista" }, relleno),
    crearNodo("span", { className: "stats-valor", textContent: String(item.total) })
  );
}

function pintarBarras(idLista, items, esColor) {
  const lista = document.getElementById(idLista);
  if (items.length === 0) {
    lista.replaceChildren(crearNodo("li", { className: "stats-vacio", textContent: "Todavía no hay datos." }));
    return;
  }
  const maximo = Math.max(...items.map(i => i.total));
  lista.replaceChildren(...items.map(i => filaBarra(i, maximo, esColor)));
}

function pintarDias(porDia) {
  const cont = document.getElementById("stats-dia");
  const dias = diasContinuos(porDia);
  if (dias.length === 0) {
    cont.replaceChildren(crearNodo("p", { className: "stats-vacio", textContent: "Todavía no hay datos." }));
    return;
  }
  const maximo = Math.max(...dias.map(d => d.total));
  const total = dias.reduce((suma, d) => suma + d.total, 0);

  const columnas = dias.map((d, i) => {
    const barra = crearNodo("span", { className: "stats-col-barra" });
    barra.style.height = `${maximo > 0 ? (d.total / maximo) * 100 : 0}%`;
    const texto = `${etiquetaDia(d.ms)}: ${d.total}`;
    // etiqueta de fecha en el primero, el último y cada 7 días
    const marca = (i === 0 || i === dias.length - 1 || i % 7 === 0) ? etiquetaDia(d.ms) : "";
    return crearNodo("div", { className: "stats-col", title: texto },
      crearNodo("span", { className: "stats-col-valor", textContent: d.total > 0 ? String(d.total) : "" }),
      crearNodo("span", { className: "stats-col-area" }, barra),
      crearNodo("span", { className: "stats-col-marca", textContent: marca })
    );
  });

  const grafica = crearNodo("div", {
    className: "stats-columnas",
    role: "img"
  }, columnas);
  grafica.setAttribute("aria-label",
    `Avistamientos por día, del ${etiquetaDia(dias[0].ms)} al ${etiquetaDia(dias[dias.length - 1].ms)}: ${total} en total, máximo ${maximo} en un día.`);
  cont.replaceChildren(grafica);
}

function mostrarEstado(mensaje, esError) {
  const el = document.getElementById("stats-estado");
  el.className = "stats-estado" + (esError ? " error" : "");
  el.replaceChildren(...(mensaje ? [crearNodo("p", { textContent: mensaje })] : []));
}

let statsUltimaPeticion = 0;

async function cargarEstadisticas() {
  const n = document.getElementById("stats-n").value;
  const grid = document.getElementById("stats-grid");
  const esta = ++statsUltimaPeticion;

  mostrarEstado("Cargando estadísticas…", false);
  try {
    const datos = await pedirEstadisticas(n);
    if (esta !== statsUltimaPeticion) return; // llegó una respuesta más nueva
    pintarBarras("stats-color", datos.por_color, true);
    pintarBarras("stats-raza", datos.por_raza, false);
    pintarDias(datos.por_dia);
    document.getElementById("stats-resumen").textContent =
      `${datos.total} ${datos.total === 1 ? "avistamiento registrado" : "avistamientos registrados"}.`;
    grid.hidden = false;
    mostrarEstado("", false);
  } catch (e) {
    if (esta !== statsUltimaPeticion) return;
    grid.hidden = true;
    mostrarEstado(e.message, true);
  }
}

// se recarga cada vez que se abre la pestaña (por si se registraron perritos nuevos)
document.querySelector('.tab[data-view="stats"]').addEventListener("click", cargarEstadisticas);
document.getElementById("stats-n").addEventListener("change", cargarEstadisticas);
