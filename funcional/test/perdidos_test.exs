defmodule Perritos.PerdidosTest do
  use ExUnit.Case, async: true

  doctest Perritos.Perdidos

  alias Perritos.{Avistamiento, Perdidos}

  @ahora ~N[2026-11-05 10:00:00]

  defp perro(id, {lat, lon}, fecha) do
    %Avistamiento{
      id: id,
      nombre: "Perro #{id}",
      raza: nil,
      colores: ["Negro"],
      lat: lat,
      lon: lon,
      foto: "/api/imagenes/#{id}.jpg",
      fecha: fecha
    }
  end

  # Centro de la celda {10, 10}: está a ~250 m de cualquier borde, así que un
  # desplazamiento de ~10 m nunca cruza a otra celda.
  defp centro, do: Perdidos.centro_de(500).({10, 10})
  defp punto(%{lat: lat, lon: lon}, dlat \\ 0.0, dlon \\ 0.0), do: {lat + dlat, lon + dlon}

  describe "reporte/4" do
    test "lista vacía no produce zonas" do
      assert Perdidos.reporte([], 14, 500, @ahora) == []
    end

    test "si ningún perro cumple el filtro no hay zonas" do
      visto_ayer = perro(1, punto(centro()), ~N[2026-11-04 09:00:00])
      assert Perdidos.reporte([visto_ayer], 14, 500, @ahora) == []
    end

    test "el límite es inclusivo: 14 días exactos entran, 13 no" do
      justo = perro(1, punto(centro()), ~N[2026-10-22 23:00:00])
      casi = perro(2, punto(centro()), ~N[2026-10-23 01:00:00])

      assert [%{total: 1, perros: [%{id: 1, dias: 14}]}] =
               Perdidos.reporte([justo, casi], 14, 500, @ahora)
    end

    test "con 0 días entra lo visto hoy" do
      hoy = perro(1, punto(centro()), ~N[2026-11-05 08:00:00])
      assert [%{total: 1}] = Perdidos.reporte([hoy], 0, 500, @ahora)
    end

    test "una fecha futura no cuenta como perdido y no truena" do
      futuro = perro(1, punto(centro()), ~N[2026-11-06 08:00:00])
      assert Perdidos.reporte([futuro], 0, 500, @ahora) == []
    end

    test "dos perros de la misma celda forman una sola zona" do
      a = perro(1, punto(centro()), ~N[2026-10-01 08:00:00])
      b = perro(2, punto(centro(), 0.0001, 0.0001), ~N[2026-10-02 08:00:00])

      assert [%{total: 2, perros: [%{id: 1}, %{id: 2}]}] =
               Perdidos.reporte([b, a], 14, 500, @ahora)
    end

    test "zonas distintas se ordenan de la más poblada a la menos poblada" do
      lejos = {25.52, -101.0}
      sola = perro(1, lejos, ~N[2026-10-01 08:00:00])
      a = perro(2, punto(centro()), ~N[2026-10-01 08:00:00])
      b = perro(3, punto(centro(), 0.0001, 0.0), ~N[2026-10-02 08:00:00])

      assert [%{total: 2}, %{total: 1}] = Perdidos.reporte([sola, a, b], 14, 500, @ahora)
    end

    test "acepta un Stream igual que una lista" do
      perros = [
        perro(1, punto(centro()), ~N[2026-10-01 08:00:00]),
        perro(2, {25.52, -101.0}, ~N[2026-10-03 08:00:00])
      ]

      assert Perdidos.reporte(Stream.map(perros, & &1), 14, 500, @ahora) ==
               Perdidos.reporte(perros, 14, 500, @ahora)
    end

    test "una fecha DateTime (columna TIMESTAMP) funciona igual que NaiveDateTime" do
      con_timestamp = perro(1, punto(centro()), ~U[2026-10-01 08:00:00Z])
      assert [%{perros: [%{id: 1, dias: 35}]}] = Perdidos.reporte([con_timestamp], 14, 500, @ahora)
    end

    test "cada ficha trae lo que el frontend necesita para pintarla" do
      a = perro(7, punto(centro()), ~N[2026-10-01 08:00:00])

      assert [%{perros: [ficha]}] = Perdidos.reporte([a], 14, 500, @ahora)

      assert ficha == %{
               id: 7,
               nombre: "Perro 7",
               raza: nil,
               colores: ["Negro"],
               foto: "/api/imagenes/7.jpg",
               dias: 35
             }
    end
  end

  describe "ordenar/1" do
    test "lista vacía" do
      assert Perdidos.ordenar([]) == []
    end

    test "del más antiguo al más reciente" do
      viejo = perro(1, {0.0, 0.0}, ~N[2026-09-01 08:00:00])
      nuevo = perro(2, {0.0, 0.0}, ~N[2026-10-01 08:00:00])
      assert Perdidos.ordenar([nuevo, viejo]) |> Enum.map(& &1.id) == [1, 2]
    end

    test "con la misma fecha desempata por id" do
      fecha = ~N[2026-10-01 08:00:00]
      a = perro(5, {0.0, 0.0}, fecha)
      b = perro(2, {0.0, 0.0}, fecha)
      assert Perdidos.ordenar([a, b]) |> Enum.map(& &1.id) == [2, 5]
    end
  end

  describe "cuadrícula" do
    test "el centro de una celda cae de vuelta en esa celda (longitud negativa)" do
      celda = Perdidos.celda_de(500)
      una_celda = celda.({25.4234, -100.9987})
      centro = Perdidos.centro_de(500).(una_celda)

      assert celda.({centro.lat, centro.lon}) == una_celda
    end

    test "dos puntos a ambos lados de un límite caen en celdas distintas" do
      celda = Perdidos.celda_de(500)
      una_celda = celda.({25.42, -101.0})
      centro = Perdidos.centro_de(500).(una_celda)

      # a más de media celda (~0.0025°) del centro, ya es otra celda
      assert celda.({centro.lat + 0.004, centro.lon}) != una_celda
    end
  end

  describe "orden superior" do
    test "sin_verse_desde/2 regresa una función reutilizable" do
      filtro = Perdidos.sin_verse_desde(@ahora, 7)

      assert is_function(filtro, 1)
      assert filtro.(%{fecha: ~N[2026-10-01 08:00:00]})
      refute filtro.(%{fecha: ~N[2026-11-03 08:00:00]})
    end

    test "perdidos/4 acepta cualquier filtro" do
      todos = fn _ -> true end
      a = perro(1, punto(centro()), ~N[2026-11-05 08:00:00])

      assert [%{total: 1}] = Perdidos.perdidos([a], todos, 500, @ahora)
    end
  end
end