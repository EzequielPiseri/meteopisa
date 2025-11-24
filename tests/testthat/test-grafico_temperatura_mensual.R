test_that("grafico_temperatura_mensual falla por columnas faltantes", {
  df <- NH0472
  df$id <- NULL
  expect_error(
    grafico_temperatura_mensual(df),
    "debe contener las columnas"
  )
})

test_that("grafico_temperatura_mensual falla si fecha no es Date", {
  df <- NH0472
  df$fecha <- as.character(df$fecha)
  expect_error(
    grafico_temperatura_mensual(df),
    "debe ser de clase Date"
  )
})

test_that("grafico_temperatura_mensual genera ggplot y colores aleatorios", {
  g <- grafico_temperatura_mensual(NH0472)
  expect_s3_class(g, "ggplot")
})

test_that("grafico_temperatura_mensual falla si la cantidad de colores es incorrecta", {
  expect_error(
    grafico_temperatura_mensual(NH0472, colores = c("red", "blue")),
    "debe coincidir"
  )
})
