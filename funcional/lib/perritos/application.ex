defmodule Perritos.Application do
  @moduledoc "CÁSCARA: arranca la conexión a la base de datos y el servidor HTTP."

  use Application

  def start(_tipo, _args) do
    hijos = [
      {MyXQL,
       name: :bd,
       hostname: System.fetch_env!("BD_HOST"),
       username: System.fetch_env!("BD_USUARIO"),
       password: System.fetch_env!("BD_PASSWORD"),
       database: System.fetch_env!("BD_NOMBRE")},
      {Bandit, plug: Perritos.Router, scheme: :http, ip: :any, port: 4000}
    ]

    Supervisor.start_link(hijos, strategy: :one_for_one, name: Perritos.Supervisor)
  end
end
