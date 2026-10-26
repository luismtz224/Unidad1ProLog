defmodule Perritos.RescateTest do
  use ExUnit.Case, async: true
  doctest Perritos.Rescate

  alias Perritos.{Avistamiento, Rescate}

  @origen {0.0, 0.0}

  defp perro(id, lat, lon), do: %Avistamiento{id: id, nombre: "perro #{id}", lat: lat, lon: lon}
  defp ids(%{paradas: paradas}), do: Enum.map(paradas, & &1.perro.id)

  test "sin perros, la ruta queda vacía y mide 0" do
    assert Rescate.ruta(@origen, []) == %{paradas: [], total_m: 0.0}
  end

  test "con un solo perro, la ruta es ir hasta él" do
    resultado = Rescate.ruta(@origen, [perro(1, 1.0, 0.0)])

    assert ids(resultado) == [1]
    assert_in_delta resultado.total_m, 111_194.93, 1.0
  end

  test "visita siempre al más cercano desde donde está parado" do
    perros = [perro(1, 0.0, 3.0), perro(2, 0.0, 1.0), perro(3, 0.0, 2.0)]
    resultado = Rescate.ruta(@origen, perros)

    assert ids(resultado) == [2, 3, 1]
    assert_in_delta resultado.total_m, 333_584.78, 1.0
  end

  test "el total es la suma de los tramos" do
    perros = [perro(1, 0.0, 3.0), perro(2, 0.0, 1.0), perro(3, 0.0, 2.0)]
    resultado = Rescate.ruta(@origen, perros)
    suma = resultado.paradas |> Enum.map(& &1.tramo_m) |> Enum.sum()

    assert_in_delta resultado.total_m, suma, 0.001
  end

  test "visita a todos los perros sin repetir ninguno" do
    perros = for id <- 1..6, do: perro(id, id * 0.01, -id * 0.02)
    resultado = Rescate.ruta(@origen, perros)

    assert resultado |> ids() |> Enum.sort() == Enum.to_list(1..6)
  end

  test "usa la métrica que recibe (orden superior); en empate gana el menor id" do
    perros = [perro(9, 5.0, 5.0), perro(4, 1.0, 1.0), perro(7, 2.0, 2.0)]
    constante = fn _punto, _otro -> 1.0 end
    resultado = Rescate.ruta(@origen, perros, constante)

    assert ids(resultado) == [4, 7, 9]
    assert resultado.total_m == 3.0
  end

  test "distancia_desde/1 regresa una función que mide desde ese punto" do
    a_distancia = Rescate.distancia_desde(@origen)

    assert a_distancia.(perro(1, 0.0, 0.0)) == 0.0
    assert_in_delta a_distancia.(perro(2, 1.0, 0.0)), 111_194.93, 1.0
  end
end
