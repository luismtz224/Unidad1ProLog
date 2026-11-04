defmodule Perritos.Perdidos do
  @moduledoc """
  NÚCLEO PURO de *perros perdidos de vista*: perros que llevan `dias` o más
  sin volver a verse, agrupados por zonas (celdas cuadradas de `tamano` metros).

  No consulta la base de datos, no lee el reloj y no recibe `conn`: todo lo
  que necesita (los avistamientos y `ahora`) le llega como argumento.
  """

  @r 6_371_000
  @lat_ref 25.42

  @doc """
  Reporte completo para la ruta HTTP: crea el filtro por días y agrupa por zonas.

  ## Ejemplos

      iex> perro = %{id: 1, nombre: "Canela", raza: nil, colores: ["Café"], foto: "/api/imagenes/1.jpg", lat: 0.0001, lon: 0.0001, fecha: ~N[2026-10-01 08:00:00]}
      iex> [zona] = Perritos.Perdidos.reporte([perro], 14, 500, ~N[2026-11-05 10:00:00])
      iex> zona.total
      1
      iex> zona.perros
      [%{id: 1, nombre: "Canela", raza: nil, colores: ["Café"], foto: "/api/imagenes/1.jpg", dias: 35}]

  Si ningún perro cumple los días, no hay zonas:

      iex> perro = %{id: 1, lat: 0.0, lon: 0.0, fecha: ~N[2026-11-04 08:00:00]}
      iex> Perritos.Perdidos.reporte([perro], 14, 500, ~N[2026-11-05 10:00:00])
      []
  """
  def reporte(avistamientos, dias, tam, ahora) do
    perdidos(avistamientos, sin_verse_desde(ahora, dias), tam, ahora)
  end

  @doc """
  REGRESA una función (filtro): `true` si el perro lleva `dias` o más sin verse.

  ## Ejemplos

      iex> filtro = Perritos.Perdidos.sin_verse_desde(~N[2026-11-05 10:00:00], 14)
      iex> filtro.(%{fecha: ~N[2026-10-01 08:00:00]})
      true
      iex> filtro.(%{fecha: ~N[2026-11-04 08:00:00]})
      false
  """
  def sin_verse_desde(ahora, dias) do
    hoy = a_dia(ahora)
    fn a -> dias_sin_verse(a, hoy) >= dias end
  end

  @doc """
  Días completos entre la fecha del avistamiento y `hoy` (un `Date`).
  Acepta `NaiveDateTime` (columna DATETIME) o `DateTime` (columna TIMESTAMP).

  ## Ejemplos

      iex> Perritos.Perdidos.dias_sin_verse(%{fecha: ~N[2026-10-01 08:00:00]}, ~D[2026-11-05])
      35
      iex> Perritos.Perdidos.dias_sin_verse(%{fecha: ~U[2026-10-01 08:00:00Z]}, ~D[2026-11-05])
      35
  """
  def dias_sin_verse(%{fecha: fecha}, hoy), do: Date.diff(hoy, a_dia(fecha))

  @doc """
  RECIBE el filtro (una función). Acepta lista o Stream.

  ## Ejemplos

      iex> perros = [%{id: 1, nombre: "A", raza: nil, colores: [], foto: nil, lat: 0.0001, lon: 0.0001, fecha: ~N[2026-11-05 08:00:00]}]
      iex> ahora = ~N[2026-11-05 10:00:00]
      iex> Perritos.Perdidos.perdidos(perros, fn _ -> true end, 500, ahora) |> length()
      1
      iex> Perritos.Perdidos.perdidos(perros, fn _ -> false end, 500, ahora)
      []
  """
  def perdidos(avistamientos, filtro, tam, ahora) when is_function(filtro, 1) do
    hoy = a_dia(ahora)
    celda = celda_de(tam)
    centro = centro_de(tam)

    avistamientos
    |> Stream.filter(filtro)                                   # el Stream del equipo
    |> Enum.group_by(fn a -> celda.({a.lat, a.lon}) end)
    |> Enum.map(fn {c, perros} -> zona(centro.(c), ordenar(perros), hoy) end)
    |> Enum.sort_by(fn z -> {-z.total, z.centro.lat, z.centro.lon} end)
  end

  defp zona(centro, perros, hoy) do
    %{
      centro: centro,
      total: length(perros),
      perros: Enum.map(perros, fn a -> ficha(a, hoy) end)
    }
  end

  defp ficha(a, hoy) do
    %{
      id: a.id,
      nombre: a.nombre,
      raza: a.raza,
      colores: a.colores,
      foto: a.foto,
      dias: dias_sin_verse(a, hoy)
    }
  end

  @doc """
  REGRESA una función: coordenada -> celda de la cuadrícula.
  Usa `floor`, así que las coordenadas negativas caen en la celda correcta.

  ## Ejemplos

      iex> celda = Perritos.Perdidos.celda_de(500)
      iex> celda.({0.0, 0.0})
      {0, 0}
      iex> celda.({-0.001, -0.001})
      {-1, -1}
  """
  def celda_de(tam) do
    fn {lat, lon} ->
      {floor(@r * rad(lon) * :math.cos(rad(@lat_ref)) / tam),
       floor(@r * rad(lat) / tam)}
    end
  end

  @doc """
  REGRESA una función: celda -> centro en lat/lon (para pintar en el mapa).
  El centro de una celda siempre cae de vuelta en esa misma celda.

  ## Ejemplos

      iex> centro = Perritos.Perdidos.centro_de(500).({10, 10})
      iex> Perritos.Perdidos.celda_de(500).({centro.lat, centro.lon})
      {10, 10}
  """
  def centro_de(tam) do
    fn {cx, cy} ->
      %{lat: grados((cy + 0.5) * tam / @r),
        lon: grados((cx + 0.5) * tam / (@r * :math.cos(rad(@lat_ref))))}
    end
  end

  @doc """
  Recursión explícita: inserción ordenada, del más antiguo al más reciente.
  Si dos fechas empatan, desempata por `id`.

  ## Ejemplos

      iex> perros = [%{id: 2, fecha: ~N[2026-10-02 08:00:00]}, %{id: 3, fecha: ~N[2026-10-01 08:00:00]}, %{id: 1, fecha: ~N[2026-10-01 08:00:00]}]
      iex> perros |> Perritos.Perdidos.ordenar() |> Enum.map(& &1.id)
      [1, 3, 2]
  """
  def ordenar([]), do: []
  def ordenar([a | resto]), do: insertar(a, ordenar(resto))

  defp insertar(a, []), do: [a]
  defp insertar(a, [b | resto] = lista) do
    case antes?(a, b) do
      true -> [a | lista]
      false -> [b | insertar(a, resto)]
    end
  end

  defp antes?(a, b) do
    case NaiveDateTime.compare(a_naive(a.fecha), a_naive(b.fecha)) do
      :lt -> true
      :gt -> false
      :eq -> a.id <= b.id      # empate: por id, para que sea determinista
    end
  end

  defp a_naive(%NaiveDateTime{} = fecha), do: fecha
  defp a_naive(%DateTime{} = fecha), do: DateTime.to_naive(fecha)

  defp a_dia(fecha), do: fecha |> a_naive() |> NaiveDateTime.to_date()

  defp rad(g), do: g * :math.pi() / 180
  defp grados(r), do: r * 180 / :math.pi()
end