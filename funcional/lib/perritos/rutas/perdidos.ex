defmodule Perritos.Rutas.Perdidos do
  @moduledoc """
  CÁSCARA HTTP de *perros perdidos de vista*.

  Se conecta en `Perritos.Router` con:

      forward "/f/perdidos", to: Perritos.Rutas.Perdidos

  Dentro de un `forward` el prefijo ya se quitó, por eso la ruta es "/".

  `GET /f/perdidos?dias=14&tamano=500`
    * `dias`   — días sin verse (por omisión 14)
    * `tamano` — lado de la celda en metros (por omisión 500)

  Aquí no hay cálculo: se lee la petición, se traen los datos, se llama al
  núcleo (`Perritos.Perdidos`) y se responde.
  """

  use Plug.Router

  alias Perritos.{Datos, Http, Perdidos}

  plug :match
  plug :dispatch

  get "/" do
    conn = fetch_query_params(conn)
    dias = entero(conn.query_params["dias"], 14)
    tamano = max(entero(conn.query_params["tamano"], 500), 1)
    ahora = NaiveDateTime.local_now()                  # efecto: leer el reloj

    case Datos.avistamientos() do                      # efecto: base de datos
      {:ok, avistamientos} ->
        Http.json(conn, 200, Perdidos.reporte(avistamientos, dias, tamano, ahora))

      {:error, _} ->
        Http.json(conn, 503, %{error: "base de datos no disponible"})
    end
  end

  match _ do
    send_resp(conn, 404, "no encontrado")
  end

  defp entero(nil, por_omision), do: por_omision

  defp entero(texto, por_omision) do
    case Integer.parse(texto) do
      {n, ""} when n >= 0 -> n
      _ -> por_omision
    end
  end
end