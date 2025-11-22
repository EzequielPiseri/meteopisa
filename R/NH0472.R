#' Datos de la estacion NH0472
#'
#' Conjunto de datos meteorologicos reales de la estacion "NH0472".
#' Este archivo se incluye en `inst/extdata/` y se utiliza para ejemplos,
#' tests y demostraciones del paquete.
#'
#' @format Un archivo CSV con columnas tipicas de estaciones meteorologicas.
#' @details
#' Para acceder a este archivo use:
#'
#' `system.file("extdata", "NH0472.csv", package = "meteopisa")`
#'
#' @source Estacion meteorologica NH0472.
#'
#' @examples
#' archivo <- system.file("extdata", "NH0472.csv", package = "meteopisa")
#' datos <- readr::read_csv(archivo, show_col_types = FALSE)
#' head(datos)
"NH0472"
