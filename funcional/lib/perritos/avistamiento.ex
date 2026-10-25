defmodule Perritos.Avistamiento do
  @moduledoc """
  Un avistamiento (un perrito registrado en el P1). Sólo datos.

  - `raza`: `nil` si es desconocida (el catálogo "Sin raza definida / criollo"
    también se convierte en `nil` al leer de la base).
  - `colores`: lista de nombres tal como están en la base (`"Negro"`, `"Café"`…),
    el color principal va primero. De 1 a 3 elementos.
  - `foto`: ruta pública lista para un `<img>`, p. ej. `"/api/imagenes/perro_01.jpg"`.
  - `fecha`: `NaiveDateTime` (hora de Saltillo).
  """

  @derive {Jason.Encoder, only: [:id, :nombre, :raza, :colores, :lat, :lon, :foto, :fecha]}
  defstruct [:id, :nombre, :raza, :colores, :lat, :lon, :foto, :fecha]
end
