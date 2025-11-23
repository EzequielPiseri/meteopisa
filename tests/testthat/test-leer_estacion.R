test_that("leer_estacion funciona correctamente", {

  ruta_temp <- tempfile(fileext = ".csv")

  datos <- leer_estacion("estacion_NH0472", ruta_temp)

  expect_s3_class(datos, "data.frame")
  expect_true(all(c("fecha", "temperatura_abrigo_150cm") %in% names(datos)) ||
                ncol(datos) > 0)
  expect_gt(nrow(datos), 0)
  expect_true(file.exists(ruta_temp))

  expect_error(
    leer_estacion("estacion_INEXISTENTE", ruta_temp),
    regexp = "no es valido",
    class = "rlang_error"
  )
})
