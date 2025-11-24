test_that("grafico_temperatura_mensual genera un ggplot valido", {

  data("NH0472")

  graf <- grafico_temperatura_mensual(NH0472)

  # 1. Devuelve un ggplot
  expect_s3_class(graf, "ggplot")

  # 2. Tiene datos
  expect_gt(nrow(graf$data), 0)

  # 3. Tiene titulo correcto
  expect_equal(graf$labels$title, "Temperatura")

  # 4. El label de la leyenda es correcto
  # (esto NO depende de scale_color_manual())
  expect_equal(graf$labels$colour, "Estacion")

  # 5. No debe generar errores al ejecutarse
  expect_error(
    grafico_temperatura_mensual(NH0472),
    NA
  )
})
