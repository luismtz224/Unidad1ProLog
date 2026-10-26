defmodule Perritos.GeoTest do
  use ExUnit.Case, async: true
  doctest Perritos.Geo

  alias Perritos.Geo

  test "el mismo punto está a 0 metros" do
    assert Geo.haversine({25.42, -100.99}, {25.42, -100.99}) == 0.0
  end

  test "un grado de latitud son unos 111.19 km" do
    assert_in_delta Geo.haversine({0.0, 0.0}, {1.0, 0.0}), 111_194.93, 1.0
  end

  test "un grado de longitud mide la mitad a 60° de latitud" do
    assert_in_delta Geo.haversine({60.0, 0.0}, {60.0, 1.0}), 55_597.5, 2.0
  end

  test "la distancia es simétrica" do
    a = {25.4483, -100.9937}
    b = {25.4233, -100.9437}
    assert Geo.haversine(a, b) == Geo.haversine(b, a)
  end
end
