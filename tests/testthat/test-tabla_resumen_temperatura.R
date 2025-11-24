test_that("tabla_resumen_temperatura funciona con datos internos", {

  res <- tabla_resumen_temperatura(
    datos_lista = list(estacion_NH0472 = NH0472),
    ids_estaciones = "estacion_NH0472"
  )

  expect_s3_class(res, "tbl_df")
  expect_equal(nrow(res), 4)
  expect_true(all(c("Media", "Desvio", "Maxima", "Minima") %in% res$Tipo))
})
