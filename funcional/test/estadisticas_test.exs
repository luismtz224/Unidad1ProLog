defmodule Perritos.EstadisticasTest do
  use ExUnit.Case, async: true

  # corre también los ejemplos (iex>) escritos en estadisticas.ex
  doctest Perritos.Estadisticas

  alias Perritos.Estadisticas

  test "cuenta los colores" do
    perros = [%{colores: ["Negro", "Blanco"]}, %{colores: ["Negro"]}]
    lentes = Estadisticas.clave(:color)

    assert Estadisticas.contar_por(perros, lentes) == %{"Negro" => 2, "Blanco" => 1}
  end

  # CASO RARO 1: perros sin raza
  test "los perros sin raza se juntan como 'Sin raza definida'" do
    perros = [%{raza: nil}, %{raza: nil}, %{raza: "Chihuahua"}]
    lentes = Estadisticas.clave(:raza)

    assert Estadisticas.contar_por(perros, lentes) ==
             %{"Sin raza definida" => 2, "Chihuahua" => 1}
  end

  test "cuenta por día" do
    perros = [
      %{fecha: ~N[2026-10-17 09:00:00]},
      %{fecha: ~N[2026-10-17 18:30:00]},
      %{fecha: ~N[2026-10-19 08:00:00]}
    ]

    lentes = Estadisticas.clave(:dia)

    assert Estadisticas.contar_por(perros, lentes) == %{"2026-10-17" => 2, "2026-10-19" => 1}
  end

  # CASO RARO 2: no hay perritos
  test "con una lista vacía no truena" do
    lentes = Estadisticas.clave(:color)

    assert Estadisticas.contar_por([], lentes) == %{}
    assert Estadisticas.mas_comunes(%{}, 5) == []
  end

  # CASO RARO 3: empate
  test "mas_comunes desempata por orden alfabético" do
    conteo = %{"Negro" => 3, "Blanco" => 3, "Café" => 1}

    assert Estadisticas.mas_comunes(conteo, 2) ==
             [%{clave: "Blanco", total: 3}, %{clave: "Negro", total: 3}]
  end

  test "contar_por acepta una función inventada por uno mismo" do
    perros = [%{colores: ["Negro"]}, %{colores: ["Negro", "Blanco"]}]
    cuantos_colores = fn perro -> [length(perro.colores)] end

    assert Estadisticas.contar_por(perros, cuantos_colores) == %{1 => 1, 2 => 1}
  end

  test "da lo mismo con una lista que con un Stream" do
    perros = [%{colores: ["Negro"]}, %{colores: ["Negro", "Blanco"]}]
    stream = Stream.map(perros, fn perro -> perro end)
    lentes = Estadisticas.clave(:color)

    assert Estadisticas.contar_por(stream, lentes) == Estadisticas.contar_por(perros, lentes)
  end
end
