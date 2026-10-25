defmodule Perritos.Datos do
  @moduledoc """
  CÁSCARA: lee los avistamientos de la base de datos del Proyecto 1 (MySQL,
  usuario de sólo lectura) y los convierte en structs para el núcleo.

  Es el único módulo que sabe cómo están guardados los datos. El núcleo
  recibe `%Perritos.Avistamiento{}` y nunca se entera de dónde vinieron.
  """

  alias Perritos.Avistamiento

  @sin_raza "Sin raza definida / criollo"

  # Un renglón por perrito; los colores llegan juntos "Negro|Blanco"
  # con el principal primero.
  @consulta """
  SELECT p.id,
         p.nombre,
         r.nombre AS raza,
         GROUP_CONCAT(c.nombre ORDER BY pc.es_principal DESC, c.nombre SEPARATOR '|') AS colores,
         p.latitud,
         p.longitud,
         p.foto_archivo,
         p.fecha_registro
  FROM perrito p
  LEFT JOIN raza r ON r.id = p.raza_id
  JOIN perrito_color pc ON pc.perrito_id = p.id
  JOIN color c ON c.id = pc.color_id
  GROUP BY p.id, r.nombre
  ORDER BY p.id
  """

  @doc "Todos los avistamientos. Regresa `{:ok, [%Avistamiento{}]}` o `{:error, motivo}`."
  def avistamientos do
    case MyXQL.query(:bd, @consulta, []) do
      {:ok, %MyXQL.Result{rows: filas}} -> {:ok, Enum.map(filas, &a_avistamiento/1)}
      {:error, error} -> {:error, error}
    end
  end

  defp a_avistamiento([id, nombre, raza, colores, lat, lon, foto, fecha]) do
    %Avistamiento{
      id: id,
      nombre: nombre,
      raza: normalizar_raza(raza),
      colores: String.split(colores, "|"),
      lat: a_flotante(lat),
      lon: a_flotante(lon),
      foto: "/api/imagenes/" <> foto,
      fecha: fecha
    }
  end

  defp normalizar_raza(@sin_raza), do: nil
  defp normalizar_raza(raza), do: raza

  # DECIMAL llega como %Decimal{}
  defp a_flotante(%Decimal{} = d), do: Decimal.to_float(d)
  defp a_flotante(n) when is_number(n), do: n * 1.0
end
