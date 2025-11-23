test_that("grafico_temperatura_mensual genera un objeto ggplot correctamente", {
  todas_las_estaciones <- dplyr::bind_rows(
    leer_estacion("estacion_NH0437", "datos/estacion_NH0437.csv"),
    leer_estacion("estacion_NH0472", "datos/estacion_NH0472.csv")
  )
  g <- grafico_temperatura_mensual(
    todas_las_estaciones,
    colores = c("tomato", "steelblue"),
    titulo = "Temperatura promedio mensual"
  )
  expect_s3_class(g, "ggplot")
  expect_true("mes" %in% names(g$data))
  expect_true("temperatura_media" %in% names(g$data))
  expect_true("id" %in% names(g$data))
})
