#' Grafico de temperatura media mensual por estacion
#'
#' Calcula la temperatura media mensual por estacion y genera un grafico
#' usando ggplot2.
#'
#' @param datos Tibble con columnas: id, fecha (Date), temperatura_abrigo_150cm.
#' @param colores Vector de colores opcional.
#' @param titulo Titulo del grafico..
#'
#' @return Un objeto ggplot2.
#'
#' @examples
#' # Cargar datos internos
#' data("NH0472")
#'
#' # Graficar la temperatura mensual
#' grafico_temperatura_mensual(NH0472)
#'
#' @export
grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {

  # 1. Validaciones
  req <- c("id", "fecha", "temperatura_abrigo_150cm")
  if (!all(req %in% names(datos))) {
    cli::cli_abort("El data frame debe contener las columnas: {toString(req)}")
  }

  if (!inherits(datos$fecha, "Date")) {
    cli::cli_abort("La columna `fecha` debe ser de clase Date.")
  }

  # 2. Crear columna mes
  datos <- datos |>
    dplyr::mutate(mes = lubridate::month(.data$fecha))

  # 3. Media mensual
  promedio_mensual <- datos |>
    dplyr::group_by(.data$id, .data$mes) |>
    dplyr::summarise(
      temperatura_media = mean(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  # 4. Colores
  if (is.null(colores)) {
    n <- length(unique(promedio_mensual$id))
    base_cols <- grDevices::colors()
    colores <- sample(base_cols, n)
    cli::cli_inform("Se seleccionaron {n} colores aleatorios.")
  } else {
    if (length(colores) != length(unique(promedio_mensual$id))) {
      cli::cli_abort(
        "La cantidad de colores ({length(colores)}) debe coincidir con las estaciones ({length(unique(promedio_mensual$id))})."
      )
    }
  }

  # 5. Grafico
  g <- ggplot2::ggplot(
    promedio_mensual,
    ggplot2::aes(x = .data$mes, y = .data$temperatura_media, color = .data$id)
  ) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::geom_point(size = 2) +
    ggplot2::scale_x_continuous(breaks = 1:12, labels = month.abb) +
    ggplot2::labs(
      x = "Mes",
      y = "Temperatura media (C)",
      color = "Estacion",
      title = titulo
    ) +
    ggplot2::scale_color_manual(values = colores) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )

  cli::cli_inform("Grafico generado correctamente.")
  return(g)
}
