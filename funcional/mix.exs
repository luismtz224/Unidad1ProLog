defmodule Perritos.MixProject do
  use Mix.Project

  def project do
    [
      app: :funcional,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # mix test NO arranca la aplicación: así las pruebas del núcleo
      # no intentan conectarse a la base de datos.
      aliases: [test: "test --no-start"]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Perritos.Application, []}
    ]
  end

  # Opción A (directo a la base, MySQL): MyXQL.
  defp deps do
    [
      {:plug, "~> 1.16"},
      {:bandit, "~> 1.5"},
      {:jason, "~> 1.4"},
      {:myxql, "~> 0.7"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end
end
