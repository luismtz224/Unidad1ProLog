defmodule Perritos.BaseTest do
  @moduledoc "Pruebas de la base compartida (struct y rutas que no tocan la base de datos)."

  use ExUnit.Case, async: true
  import Plug.Test

  alias Perritos.{Avistamiento, Router}

  test "el struct Avistamiento se convierte a JSON con sus campos públicos" do
    a = %Avistamiento{
      id: 1,
      nombre: "Firulais",
      raza: nil,
      colores: ["Negro", "Blanco"],
      lat: 25.4483,
      lon: -100.9937,
      foto: "/api/imagenes/perro_01.jpg",
      fecha: ~N[2026-10-19 08:00:00]
    }

    assert %{"nombre" => "Firulais", "raza" => nil, "colores" => ["Negro", "Blanco"]} =
             a |> Jason.encode!() |> Jason.decode!()
  end

  test "GET /f/salud responde ok" do
    conn = Router.call(conn(:get, "/f/salud"), Router.init([]))
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "una ruta que no existe responde 404" do
    conn = Router.call(conn(:get, "/f/no-existe"), Router.init([]))
    assert conn.status == 404
  end
end
