defmodule Perritos.Rutas.Rescate do
  @moduledoc "Cáscara de la ruta de rescate: GET /f/rescate?lat=&lon=&radio="
  use Plug.Router
  alias Perritos.{Datos, Http, Rescate}

  plug :match
  plug :dispatch

  get "/" do
    conn = fetch_query_params(conn)

    with {:ok, origen} <- origen(conn.query_params),
         {:ok, radio} <- radio(conn.query_params["radio"]),
         {:ok, avistamientos} <- Datos.avistamientos() do
      cuerpo =
        origen
        |> Rescate.ruta(Rescate.en_zona(origen, radio, avistamientos))
        |> a_json()

      Http.json(conn, 200, cuerpo)
    else
      {:error, :parametros} -> Http.json(conn, 400, %{error: "faltan lat y lon válidos"})
      {:error, _} -> Http.json(conn, 503, %{error: "base de datos no disponible"})
    end
  end

  defp origen(%{"lat" => lat, "lon" => lon}) do
    with {la, ""} <- Float.parse(lat),
         {lo, ""} <- Float.parse(lon) do
      {:ok, {la, lo}}
    else
      _ -> {:error, :parametros}
    end
  end

  defp origen(_), do: {:error, :parametros}

  defp radio(nil), do: {:ok, 1_000.0}

  defp radio(texto) do
    case Float.parse(texto) do
      {r, ""} when r > 0 -> {:ok, r}
      _ -> {:error, :parametros}
    end
  end

  defp a_json(%{paradas: paradas, total_m: total}) do
    %{
      total_m: Float.round(total, 1),
      paradas:
        paradas
        |> Enum.with_index(1)
        |> Enum.map(fn {p, n} ->
          %{orden: n, id: p.perro.id, nombre: p.perro.nombre,
            lat: p.perro.lat, lon: p.perro.lon, tramo_m: Float.round(p.tramo_m, 1)}
        end)
    }
  end
end