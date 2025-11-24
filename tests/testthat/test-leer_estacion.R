test_that("leer_estacion falla con id invalido", {
  ruta <- tempfile(fileext = ".csv")
  expect_error(
    leer_estacion("ID_NO_EXISTE", ruta),
    "no es valido"
  )
})

test_that("leer_estacion falla si id no es character", {
  expect_error(
    leer_estacion(123, "archivo.csv"),
    "cadena de texto"
  )
})

test_that("leer_estacion falla si ruta no es character", {
  expect_error(
    leer_estacion("estacion_NH0472", 123),
    "cadena de texto"
  )
})

test_that("leer_estacion lee archivo local existente sin descargar", {
  ruta <- tempfile(fileext = ".csv")

  # crear archivo local simulado
  write.csv(NH0472, ruta, row.names = FALSE)

  res <- leer_estacion("estacion_NH0472", ruta)
  expect_s3_class(res, "tbl_df")
  expect_equal(nrow(res), nrow(NH0472))
})
