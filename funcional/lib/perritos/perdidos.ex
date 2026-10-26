defmodule Perritos.Perdidos do
  @r 6_371_000
  @lat_ref 25.42

  @doc "Reporte completo para la ruta HTTP: crea el filtro por días y agrupa por zonas."
  def reporte(avistamientos, dias, tamano, ahora) do
    perdidos(avistamientos, sin_verse_desde(ahora, dias), tamano, ahora)
  end

  def sin_verse_desde(ahora, dias) do
    hoy = NaiveDateTime.to_date(ahora)
    fn a -> dias_sin_verse(a, hoy) >= dias end
  end

  def dias_sin_verse(%{fecha: fecha}, hoy),
    do: Date.diff(hoy, NaiveDateTime.to_date(fecha))

  @doc "RECIBE el filtro (una función). Acepta lista o Stream."
  def perdidos(avistamientos, filtro, tamano, ahora) when is_function(filtro, 1) do
    hoy = NaiveDateTime.to_date(ahora)
    celda = celda_de(tamano)
    centro = centro_de(tamano)

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

  @doc "REGRESA una función: coordenada -> celda de la cuadrícula."
  def celda_de(tamano) do
    fn {lat, lon} ->
      {floor(@r * rad(lon) * :math.cos(rad(@lat_ref)) / tamano),
       floor(@r * rad(lat) / tamano)}
    end
  end

  @doc "REGRESA una función: celda -> centro en lat/lon (para pintar en el mapa)."
  def centro_de(tamano) do
    fn {cx, cy} ->
      %{lat: grados((cy + 0.5) * tamano / @r),
        lon: grados((cx + 0.5) * tamano / (@r * :math.cos(rad(@lat_ref))))}
    end
  end

  @doc "Recursión explícita: inserción ordenada, del más antiguo al más reciente."
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
    case NaiveDateTime.compare(a.fecha, b.fecha) do
      :lt -> true
      :gt -> false
      :eq -> a.id <= b.id      # empate: por id, para que sea determinista
    end
  end

  defp rad(g), do: g * :math.pi() / 180
  defp grados(r), do: r * 180 / :math.pi()
end