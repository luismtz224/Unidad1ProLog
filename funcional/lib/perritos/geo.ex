defmodule Perritos.Geo do
  @moduledoc """
  Geometría pura sobre la Tierra. Sólo funciones puras: sin base de datos ni HTTP.
  """

  @radio_tierra_m 6_371_000

  @doc """
  Distancia en metros entre dos puntos `{lat, lon}` en grados (fórmula de haversine).

  ## Ejemplos

      iex> Perritos.Geo.haversine({25.4, -101.0}, {25.4, -101.0})
      0.0

      iex> Perritos.Geo.haversine({0.0, 0.0}, {1.0, 0.0}) |> round()
      111195
  """
  def haversine({lat1, lon1}, {lat2, lon2}) do
    phi1 = radianes(lat1)
    phi2 = radianes(lat2)
    delta_phi = radianes(lat2 - lat1)
    delta_lambda = radianes(lon2 - lon1)

    a =
      :math.pow(:math.sin(delta_phi / 2), 2) +
        :math.cos(phi1) * :math.cos(phi2) * :math.pow(:math.sin(delta_lambda / 2), 2)

    2 * @radio_tierra_m * :math.asin(:math.sqrt(min(a, 1.0)))
  end

  defp radianes(grados), do: grados * :math.pi() / 180
end
