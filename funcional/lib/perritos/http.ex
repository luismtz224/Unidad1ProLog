defmodule Perritos.Http do
  @moduledoc """
  CÁSCARA: utilería compartida por los routers para responder JSON.
  """

  import Plug.Conn

  @doc "Responde `datos` (mapas, listas, structs con `@derive Jason.Encoder`) como JSON."
  def json(conn, status, datos) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode!(datos))
  end
end
