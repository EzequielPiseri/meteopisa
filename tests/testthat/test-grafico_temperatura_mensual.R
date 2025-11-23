test_that("grafico_temperatura_mensual genera un gráfico ggplot válido", {
  data("NH0472", package = "meteopisa")

  g <- grafico_temperatura_mensual(NH0472)

  # Debe devolver un objeto ggplot
  expect_s3_class(g, "ggplot")
})

test_that("grafico_temperatura_mensual falla si no recibe un data.frame", {
  expect_error(grafico_temperatura_mensual(123))
  expect_error(grafico_temperatura_mensual("texto"))
})
