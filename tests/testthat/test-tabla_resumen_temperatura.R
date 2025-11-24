test_that("tabla_resumen_temperatura funciona con datos internos", {

  data("NH0472")

  resumen <- tabla_resumen_temperatura(
    datos_lista = list(estacion_NH0472 = NH0472)
  )

  expect_s3_class(resumen, "data.frame")
  expect_true(all(c("id", "Tipo", "Temperatura") %in% names(resumen)))

  # Validaciones simples
  expect_true(any(resumen$Tipo == "Media"))
  expect_true(any(resumen$Tipo == "Maxima"))
  expect_true(any(resumen$Tipo == "Minima"))
})
