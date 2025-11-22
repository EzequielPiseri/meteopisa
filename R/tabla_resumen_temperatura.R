#' Resumen estadistico de temperatura por estacion
#'
#' @description
#' Calcula media, desvio estandar, maxima y minima de temperatura para una o mas
#' estaciones. Puede funcionar en dos modos:
#'
#' 1) Usando datasets internos (`datos_lista`), ideal para examples y tests.
#' 2) Descargando o leyendo archivos reales mediante `leer_estacion()`.
#'
#' @param ids_estaciones Vector opcional de IDs de estaciones. Se usa si
#'   `datos_lista` es NULL.
#'
#' @param datos_lista Lista opcional de data frames ya cargados, con nombres
#'   correspondientes a los IDs de estacion.
#'
#' @return Un tibble en formato largo con columnas:
#' `id`, `Tipo`, `Temperatura`.
#'
#' @examples
#' # Usando el dataset interno (modo recomendado para examples)
#' data("NH0472")
#'
#' tabla_resumen_temperatura(
#'   datos_lista = list(estacion_NH0472 = NH0472)
#' )
#'
#' @export
tabla_resumen_temperatura <- function(ids_estaciones = NULL, datos_lista = NULL) {

  # -------------------------- #
  # 1. Validaciones de entrada #
  # -------------------------- #

  # Caso 1: usar datos ya cargados
  if (!is.null(datos_lista)) {
    if (!is.list(datos_lista)) {
      cli::cli_abort("`datos_lista` debe ser una lista de data frames.")
    }

    # Validar que cada data frame tenga la columna necesaria
    for (nm in names(datos_lista)) {
      df <- datos_lista[[nm]]
      if (!"temperatura_abrigo_150cm" %in% names(df)) {
        cli::cli_abort("El dataset '{nm}' no contiene la columna `temperatura_abrigo_150cm`.")
      }
      df$id <- nm
      datos_lista[[nm]] <- df
    }

    lista_datos <- datos_lista

  } else {

    # Caso 2: descargar/leer estaciones reales
    if (is.null(ids_estaciones)) {
      cli::cli_abort("Debes especificar `ids_estaciones` o `datos_lista`.")
    }

    if (!is.character(ids_estaciones)) {
      cli::cli_abort("`ids_estaciones` debe ser un vector de texto.")
    }

    lista_datos <- list()

    for (id in ids_estaciones) {

      ruta <- file.path(tempdir(), paste0(id, ".csv"))

      datos <- try(leer_estacion(id, ruta), silent = TRUE)

      if (inherits(datos, "try-error")) {
        cli::cli_abort("No se pudo leer la estacion {id}.")
      }

      datos$id <- id
      lista_datos[[id]] <- datos
    }
  }

  # ------------------------------------------- #
  # 2. Unificar datos y calcular estadisticas   #
  # ------------------------------------------- #

  todas <- dplyr::bind_rows(lista_datos)

  resumen <- todas |>
    dplyr::group_by(.data$id) |>
    dplyr::summarise(
      Media   = mean(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Desvio  = stats::sd(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Maxima  = max(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Minima  = min(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  # ------------------------------------------- #
  # 3. Formato largo                            #
  # ------------------------------------------- #

  resumen_largo <- tidyr::pivot_longer(
    resumen,
    cols = c("Media", "Desvio", "Maxima", "Minima"),
    names_to = "Tipo",
    values_to = "Temperatura"
  )

  cli::cli_inform("Resumen generado correctamente.")

  return(resumen_largo)
}
