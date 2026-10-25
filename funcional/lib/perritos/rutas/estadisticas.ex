defmodule Perritos.Rutas.Estadisticas do
  @moduledoc """
  Parte web de Estadísticas: `GET /f/estadisticas`.

  Parámetro opcional: `n` = cuántos colores y razas más comunes (5 si no se pone).
  Aquí sólo se lee la petición y la base de datos; la cuenta la hace
  `Perritos.Estadisticas`.
  """

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn = fetch_query_params(conn)
    cuantos = entero(conn.query_params["n"], 5)

    case Perritos.Datos.avistamientos() do
      {:ok, avistamientos} ->
        Perritos.Http.json(conn, 200, Perritos.Estadisticas.resumen(avistamientos, cuantos))

      {:error, _} ->
        Perritos.Http.json(conn, 503, %{error: "base de datos no disponible"})
    end
  end

  match _ do
    send_resp(conn, 404, "no encontrado")
  end

  defp entero(nil, por_omision), do: por_omision

  defp entero(texto, por_omision) do
    case Integer.parse(texto) do
      {numero, ""} when numero > 0 -> numero
      _ -> por_omision
    end
  end
end
