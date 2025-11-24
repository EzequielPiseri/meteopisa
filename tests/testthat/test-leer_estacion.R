test_that("leer_estacion devuelve un data.frame cuando se lee un archivo ya existente", {

  # Usamos el dataset interno en lugar de descargar
  archivo <- system.file("extdata", "NH0472.csv", package = "meteopisa")
  ruta_temp <- tempfile(fileext = ".csv")

  # Copiamos el archivo interno al tempdir
  file.copy(archivo, ruta_temp, overwrite = TRUE)

  datos <- leer_estacion("estacion_NH0472", ruta_temp)

  expect_s3_class(datos, "data.frame")
  expect_true(nrow(datos) > 0)
  expect_true(ncol(datos) > 0)
})

test_that("leer_estacion crea carpeta si no existe", {

  archivo <- system.file("extdata", "NH0472.csv", package = "meteopisa")
  ruta_temp <- file.path(tempdir(), "nueva_carpeta_test", "archivo.csv")

  # Copia manual para que exista antes de leer
  dir.create(dirname(ruta_temp), recursive = TRUE, showWarnings = FALSE)
  file.copy(archivo, ruta_temp, overwrite = TRUE)

  expect_no_error(
    leer_estacion("estacion_NH0472", ruta_temp)
  )
})
