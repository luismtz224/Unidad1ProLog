#!/usr/bin/env python3
"""
Genera db/05_datos_muestra.sql: avistamientos de muestra para el Proyecto 2.

Uso (desde la raíz del repositorio):
    python3 db/generar_datos_muestra.py > db/05_datos_muestra.sql

Es determinista (semilla fija): siempre produce el mismo archivo.
Sólo usa la biblioteca estándar de Python.

Qué trae, a propósito, para que se luzcan las funcionalidades del P2:
  - Concentraciones en 5 zonas de Saltillo (zonas / estadísticas).
  - Fechas repartidas en ~70 días; varios perros con avistamientos viejos
    que no se repiten (perdidos de vista).
  - 14 parejas "casi duplicadas": mismos colores, ubicación a menos de
    ~150 m, nombre distinto, días después (posibles duplicados / línea de tiempo).
  - Razas y colores del catálogo real (db/02_catalogos.sql).
"""
import math
import random
import uuid
from datetime import datetime, timedelta

random.seed(224)

TOTAL_BASE = 106          # + 14 duplicados = 120 avistamientos nuevos (+15 del P1 = 135)
N_DUPLICADOS = 14
AHORA = datetime(2026, 10, 23, 20, 0, 0)
DIAS_ATRAS = 70

# centro aproximado de cada zona (lat, lon), dispersión en metros, peso
ZONAS = [
    ("Alameda",        25.4307, -100.9975, 350, 30),
    ("Centro",         25.4232, -100.9926, 300, 25),
    ("Campus Narro",   25.3556, -101.0306, 450, 15),
    ("Las Maravillas", 25.4580, -100.9830, 400, 15),
    ("Ramos Arizpe",   25.5400, -100.9490, 500, 15),
]

NOMBRES = [
    "Firu", "Manchas", "Canelo", "Pelusa", "Bruno", "Kiara", "Max", "Nala", "Thor", "Coco",
    "Rufo", "Lola", "Simba", "Chispa", "Dobby", "Pinta", "Osito", "Mora", "Tacho", "Peque",
    "Gordo", "Flaca", "Chucho", "Canica", "Zeus", "Princesa", "Rayo", "Bola", "Pulgas", "Duque",
    "Mochi", "Nube", "Trueno", "Estrella", "Chato", "Canela", "Tigre", "Sombra", "Panda", "Ceniza",
    "Bimba", "Orejas", "Juanito", "Doña Lola", "Pirata", "Galleta", "Rocko", "Maya", "Lupe", "Beto",
    "Toño", "Pelos", "Zorro", "Nieve", "Gato", "Tuerto", "Mancha", "Fiera", "Cachorro", "Don Chuy",
    "Chiquis", "Kaiser", "Luna Negra", "Pelón", "Greñas", "Bigotes", "Cenizo", "Mostaza", "Churro", "Taco",
    "Burrito", "Chilaquil", "Pozole", "Elote", "Tamal", "Frijol", "Cacahuate", "Nopal", "Aguacate", "Jitomate",
    "Mango", "Limón", "Piñata", "Cometa", "Volcán", "Cactus", "Mezquite", "Sarape", "Rebozo", "Papelito",
    "Gaspar", "Melchor", "Baltazar", "Clavito", "Tornillo", "Tuerca", "Martillo", "Soldador", "Pegamento", "Lija",
    "Brocha", "Pincel", "Lápiz", "Goma", "Regla", "Compás", "Cuaderno", "Borrador", "Tijeras", "Engrapadora",
]

RAZAS = [
    "Labrador Retriever", "Pastor Alemán", "Chihuahua", "Xoloitzcuintle", "Schnauzer",
    "Pitbull / Terrier americano", "Husky Siberiano", "Salchicha (Dachshund)",
    "Poodle / Caniche", "Border Collie",
]
CRIOLLO = "Sin raza definida / criollo"

# combinaciones de colores (el primero es el principal) y su peso
COMBOS = [
    (["Negro"], 10), (["Café"], 12), (["Blanco"], 6), (["Dorado"], 8), (["Gris"], 4),
    (["Crema"], 5), (["Rojizo"], 3), (["Atigrado"], 3), (["Manchado"], 3),
    (["Negro", "Blanco"], 14), (["Café", "Blanco"], 8), (["Dorado", "Blanco"], 5),
    (["Negro", "Café"], 7), (["Gris", "Blanco"], 4), (["Canela", "Blanco"], 3),
    (["Blanco", "Negro", "Café"], 5), (["Café", "Negro", "Blanco"], 3), (["Dorado", "Crema", "Blanco"], 2),
]

FOTOS = [f"perro_{i:02d}.jpg" for i in range(1, 16)]


def mover(lat, lon, metros, rumbo):
    """Desplaza un punto `metros` hacia `rumbo` (radianes)."""
    dlat = (metros * math.cos(rumbo)) / 111_320
    dlon = (metros * math.sin(rumbo)) / (111_320 * math.cos(math.radians(lat)))
    return lat + dlat, lon + dlon


def punto_en_zona():
    zona = random.choices(ZONAS, weights=[z[4] for z in ZONAS])[0]
    _, lat, lon, sigma, _ = zona
    metros = abs(random.gauss(0, sigma))
    return mover(lat, lon, metros, random.uniform(0, 2 * math.pi))


def fecha_aleatoria():
    # la mayoría recientes; una cola larga de viejos
    dias = int(random.triangular(0, DIAS_ATRAS, 8))
    return (AHORA - timedelta(days=dias, hours=random.randint(0, 11), minutes=random.randint(0, 59))).replace(second=0)


def raza_aleatoria():
    r = random.random()
    if r < 0.45:
        return None            # el formulario del P1 guarda NULL si no se elige raza
    if r < 0.55:
        return CRIOLLO
    return random.choice(RAZAS)


def sql_texto(s):
    return "'" + s.replace("'", "''") + "'"


def sql_raza(raza):
    return "NULL" if raza is None else f"(SELECT id FROM raza WHERE nombre = {sql_texto(raza)})"


def emitir(i, a):
    clave = uuid.uuid5(uuid.NAMESPACE_URL, f"perritos-p2-muestra-{i}")
    lineas = [
        f"-- Muestra {i}: {a['nombre']}",
        "INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES "
        f"({sql_texto(a['nombre'])}, {sql_raza(a['raza'])}, {sql_texto(a['foto'])}, "
        f"{a['lat']:.7f}, {a['lon']:.7f}, '{a['fecha']:%Y-%m-%d %H:%M:%S}', '{clave}');",
        "SET @perrito_id = LAST_INSERT_ID();",
    ]
    for j, color in enumerate(a["colores"]):
        lineas.append(
            "INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES "
            f"(@perrito_id, (SELECT id FROM color WHERE nombre = {sql_texto(color)}), {'TRUE' if j == 0 else 'FALSE'});"
        )
    return "\n".join(lineas)


def main():
    nombres = NOMBRES[:]
    random.shuffle(nombres)
    combos = [c for c, _ in COMBOS]
    pcombos = [p for _, p in COMBOS]

    base = []
    for k in range(TOTAL_BASE):
        lat, lon = punto_en_zona()
        base.append({
            "nombre": nombres[k % len(nombres)] + ("" if k < len(nombres) else f" {k // len(nombres) + 1}"),
            "raza": raza_aleatoria(),
            "colores": random.choices(combos, weights=pcombos)[0],
            "lat": lat, "lon": lon,
            "foto": FOTOS[k % len(FOTOS)],
            "fecha": fecha_aleatoria(),
        })

    # parejas casi duplicadas: mismo perro, otro vecino, otro nombre, días después
    duplicados = []
    for original in random.sample(base, N_DUPLICADOS):
        lat, lon = mover(original["lat"], original["lon"], random.uniform(15, 140), random.uniform(0, 2 * math.pi))
        colores = original["colores"][:]
        if len(colores) > 1 and random.random() < 0.5:
            colores = colores[::-1]        # el otro vecino ve primero el otro color
        duplicados.append({
            "nombre": random.choice(["Chato", "Güero", "Negrito", "Peludo", "Flaquito", "Manchitas", "Cafecito"]),
            "raza": original["raza"],
            "colores": colores,
            "lat": lat, "lon": lon,
            "foto": original["foto"],
            "fecha": min(AHORA - timedelta(hours=3), original["fecha"] + timedelta(days=random.randint(1, 9), hours=random.randint(0, 8))),
        })

    todos = sorted(base + duplicados, key=lambda a: a["fecha"])

    print("-- ============================================================")
    print("-- 05_datos_muestra.sql  (GENERADO por db/generar_datos_muestra.py)")
    print(f"-- {len(todos)} avistamientos de muestra para el Proyecto 2.")
    print("-- No editar a mano: modifica el generador y vuelve a generarlo.")
    print("-- ============================================================")
    print("USE perritos_calle;\n")
    for i, a in enumerate(todos, start=1):
        print(emitir(i, a))
        print()


if __name__ == "__main__":
    main()
