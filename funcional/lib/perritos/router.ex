defmodule Perritos.Router do
  @moduledoc """
  CÁSCARA HTTP: traduce peticiones en llamadas al núcleo. Aquí no hay cálculo.

  Cada funcionalidad tiene su propio router en `lib/perritos/rutas/` y se
  conecta aquí con `forward` (ver abajo). Así cada integrante trabaja en su
  archivo y casi no hay conflictos al fusionar.
  """

  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json, :urlencoded, :multipart],
    pass: ["*/*"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/f/salud" do
    send_resp(conn, 200, "ok")
  end

  # Todos los avistamientos tal como los ve el núcleo (sirve para depurar).
  get "/f/avistamientos" do
    case Perritos.Datos.avistamientos() do
      {:ok, avistamientos} -> Perritos.Http.json(conn, 200, avistamientos)
      {:error, _} -> Perritos.Http.json(conn, 503, %{error: "base de datos no disponible"})
    end
  end

  # ===================================================================
  # FUNCIONALIDADES — cada autor descomenta/agrega SU línea (y sólo la suya).
  # Cada una vive en lib/perritos/rutas/<nombre>.ex con `use Plug.Router`.
  # ===================================================================

  # forward "/f/busqueda", to: Perritos.Rutas.Busqueda

  # (deja estas líneas en blanco para que Git no marque conflicto)

  # forward "/f/duplicados", to: Perritos.Rutas.Duplicados

  # (deja estas líneas en blanco para que Git no marque conflicto)

  # forward "/f/estadisticas", to: Perritos.Rutas.Estadisticas

  # ===================================================================

  match _ do
    send_resp(conn, 404, "no encontrado")
  end
end
