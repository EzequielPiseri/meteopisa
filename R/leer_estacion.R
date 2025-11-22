#' Lee y descarga datos meteorologicos de una estacion
#'
#' Descarga (si es necesario) y lee un archivo CSV con datos
#' meteorologicos correspondientes a una estacion especifica.
#'
#' @param id_estacion Cadena de texto con el identificador de la estacion.
#' @param ruta Cadena de texto indicando donde guardar o leer el archivo CSV.
#'
#' @return Un tibble con los datos meteorologicos de la estacion.
#'
#' @examples
#' data("NH0472")
#' head(NH0472)
#'
#' @export
leer_estacion <- function(id_estacion, ruta) {

  # 1. Validacion de argumentos
  if (!is.character(id_estacion) || length(id_estacion) != 1) {
    cli::cli_abort("`id_estacion` debe ser una cadena de texto.")
  }
  if (!is.character(ruta) || length(ruta) != 1) {
    cli::cli_abort("`ruta` debe ser una cadena de texto con la ruta del archivo.")
  }

  # 2. Tabla de URLs
  urls <- list(
    estacion_NH0472 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
    estacion_NH0910 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
    estacion_NH0046 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
    estacion_NH0098 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
    estacion_NH0437 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv"
  )

  if (!id_estacion %in% names(urls)) {
    cli::cli_abort(
      "El id '{id_estacion}' no es valido. Los valores permitidos son: {toString(names(urls))}."
    )
  }

  url <- urls[[id_estacion]]
  directorio <- dirname(ruta)

  # 3. Crear carpeta si no existe
  if (!dir.exists(directorio)) {
    cli::cli_inform("Creando carpeta: {directorio}")
    dir.create(directorio, recursive = TRUE, showWarnings = FALSE)
  }

  # 4. Descargar archivo si no existe
  if (!file.exists(ruta)) {
    cli::cli_inform("Descargando datos de la estacion {id_estacion}...")

    descarga_ok <- try(
      utils::download.file(url, ruta, mode = "wb", quiet = TRUE),
      silent = TRUE
    )

    if (inherits(descarga_ok, "try-error")) {
      cli::cli_abort("No se pudo descargar el archivo desde: {url}")
    }

    if (!file.exists(ruta)) {
      cli::cli_abort("La descarga fallo y el archivo no existe en la ruta indicada.")
    }

  } else {
    cli::cli_inform("El archivo ya existe. Leyendo CSV...")
  }

  # 5. Leer datos
  datos <- try(
    readr::read_csv(ruta, show_col_types = FALSE, progress = FALSE),
    silent = TRUE
  )

  if (inherits(datos, "try-error")) {
    cli::cli_abort("No se pudo leer el archivo CSV: {ruta}")
  }

  cli::cli_inform(
    "Lectura completada. El dataset tiene {nrow(datos)} filas y {ncol(datos)} columnas."
  )

  return(datos)
}
