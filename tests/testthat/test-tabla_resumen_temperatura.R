test_that("tabla_resumen_temperatura genera un resumen válido", {
  data("NH0472", package = "meteopisa")

  res <- tabla_resumen_temperatura(
    datos_lista = list(estacion_NH0472 = NH0472)
  )

  # Debe devolver un tibble/data.frame
  expect_s3_class(res, "data.frame")

  # Columnas esperadas
  expect_true(all(c("id", "Tipo", "Temperatura") %in% names(res)))

  # Debe contener exactamente 4 filas (Media, Desvio, Maxima, Minima)
  expect_equal(nrow(res), 4)

  # id correcto
  expect_equal(unique(res$id), "estacion_NH0472")

  # Los valores deben ser numéricos
  expect_type(res$Temperatura, "double")
})

test_that("tabla_resumen_temperatura falla si no recibe una lista válida", {
  expect_error(tabla_resumen_temperatura(datos_lista = 123))
  expect_error(tabla_resumen_temperatura(datos_lista = list()))
})
