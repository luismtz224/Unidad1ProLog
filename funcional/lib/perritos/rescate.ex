defmodule Perritos.Rescate do
  @moduledoc """
  NÚCLEO PURO de la ruta de rescate: dado un punto de partida y una lista de
  perros, propone el orden de visita (vecino más cercano) y la distancia total.

  No consulta la base de datos, no recibe `conn` y no imprime. Los perros son
  cualquier mapa o struct con `:id`, `:lat` y `:lon` (por ejemplo
  `%Perritos.Avistamiento{}`).
  """

  alias Perritos.Geo

  @doc """
  Función que regresa una función: la distancia de un perro al `punto` dado.

  ## Ejemplos

      iex> a_distancia = Perritos.Rescate.distancia_desde({0.0, 0.0})
      iex> a_distancia.(%{lat: 0.0, lon: 0.0})
      0.0
  """
  def distancia_desde(punto, metrica \\ &Geo.haversine/2) do
    fn perro -> metrica.(punto, coordenadas(perro)) end
  end

  @doc """
  Ruta del vecino más cercano. Recibe la métrica como función (por omisión,
  haversine en metros). Regresa `%{paradas: [...], total_m: metros}`; cada
  parada trae el `perro` y el `tramo_m` desde la parada anterior.

  ## Ejemplos

      iex> perros = [%{id: 1, lat: 0.0, lon: 2.0}, %{id: 2, lat: 0.0, lon: 1.0}]
      iex> %{paradas: paradas} = Perritos.Rescate.ruta({0.0, 0.0}, perros)
      iex> paradas |> Enum.map(& &1.perro.id)
      [2, 1]
  """
  def ruta(origen, perros, metrica \\ &Geo.haversine/2) do
    paradas = recorrer(origen, perros, metrica)

    %{
      paradas: paradas,
      total_m: paradas |> Enum.map(& &1.tramo_m) |> Enum.reduce(0.0, &+/2)
    }
  end

  # Recursión explícita: sin perros no hay paradas; con perros, se toma el más
  # cercano, se quita de la lista y se repite desde donde quedó.
  defp recorrer(_punto, [], _metrica), do: []

  defp recorrer(punto, perros, metrica) do
    {perro, tramo} = mas_cercano(punto, perros, metrica)
    restantes = List.delete(perros, perro)
    [%{perro: perro, tramo_m: tramo} | recorrer(coordenadas(perro), restantes, metrica)]
  end

  # Si hay empate de distancia, gana el de menor id (resultado determinista).
  defp mas_cercano(punto, perros, metrica) do
    a_distancia = distancia_desde(punto, metrica)
    perro = Enum.min_by(perros, &{a_distancia.(&1), &1.id})
    {perro, a_distancia.(perro)}
  end

  defp coordenadas(%{lat: lat, lon: lon}), do: {lat, lon}
end
