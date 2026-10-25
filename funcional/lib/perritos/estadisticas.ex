defmodule Perritos.Estadisticas do
  @moduledoc """
  Cuenta perritos: por color, por raza y por día.

  Son funciones puras: reciben una lista de perritos y devuelven el
  resultado. No tocan la base de datos ni la página web.
  """

  @doc """
  Devuelve una **función** (unos "lentes") que dice qué mirar de cada perrito.

  Se le pide `:color`, `:raza` o `:dia`.

      iex> ver_raza = Perritos.Estadisticas.clave(:raza)
      iex> ver_raza.(%{raza: "Chihuahua"})
      ["Chihuahua"]
      iex> ver_raza.(%{raza: nil})
      ["Sin raza definida"]
  """
  def clave(:color), do: fn perro -> perro.colores end
  def clave(:raza), do: fn perro -> [nombre_raza(perro.raza)] end
  def clave(:dia), do: fn perro -> [dia_de(perro.fecha)] end

  defp nombre_raza(nil), do: "Sin raza definida"
  defp nombre_raza(raza), do: raza

  defp dia_de(fecha) do
    fecha
    |> NaiveDateTime.to_date()
    |> Date.to_iso8601()
  end

  @doc """
  Cuenta cuántos perritos hay de cada cosa. **Recibe una función** que dice
  qué mirar (la que da `clave/1`). Sirve con una lista o con un `Stream`.

      iex> perros = [%{colores: ["Negro", "Blanco"]}, %{colores: ["Negro"]}]
      iex> Perritos.Estadisticas.contar_por(perros, Perritos.Estadisticas.clave(:color))
      %{"Blanco" => 1, "Negro" => 2}
  """
  def contar_por(perros, que_mirar) do
    Enum.reduce(perros, %{}, fn perro, conteo ->
      sumar(que_mirar.(perro), conteo)
    end)
  end

  # Recursión: toma la primera clave, súmale 1 y sigue con las demás.
  defp sumar([], conteo), do: conteo

  defp sumar([primera | demas], conteo) do
    sumar(demas, Map.update(conteo, primera, 1, fn n -> n + 1 end))
  end

  @doc """
  Los que más se repiten, del mayor al menor. Si hay empate, por orden alfabético.

      iex> Perritos.Estadisticas.mas_comunes(%{"a" => 1, "b" => 3, "c" => 3}, 2)
      [%{clave: "b", total: 3}, %{clave: "c", total: 3}]
  """
  def mas_comunes(conteo, cuantos) do
    conteo
    |> Enum.sort_by(fn {nombre, total} -> {-total, nombre} end)
    |> Enum.take(cuantos)
    |> Enum.map(fn {nombre, total} -> %{clave: nombre, total: total} end)
  end

  @doc """
  Lo mismo que `mas_comunes/2` pero sin recortar y en orden alfabético.
  Sirve para los días: como la fecha va año-mes-día, queda en orden de calendario.

      iex> Perritos.Estadisticas.ordenar_por_clave(%{"2026-10-19" => 2, "2026-10-17" => 1})
      [%{clave: "2026-10-17", total: 1}, %{clave: "2026-10-19", total: 2}]
  """
  def ordenar_por_clave(conteo) do
    conteo
    |> Enum.sort()
    |> Enum.map(fn {nombre, total} -> %{clave: nombre, total: total} end)
  end

  @doc """
  Junta todo lo que va en la pantalla de estadísticas.
  `cuantos` es cuántos colores y razas más comunes se muestran.
  """
  def resumen(perros, cuantos) do
    %{
      total: Enum.count(perros),
      por_color: perros |> contar_por(clave(:color)) |> mas_comunes(cuantos),
      por_raza: perros |> contar_por(clave(:raza)) |> mas_comunes(cuantos),
      por_dia: perros |> contar_por(clave(:dia)) |> ordenar_por_clave()
    }
  end
end
