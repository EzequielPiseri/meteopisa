test_that("leer_estacion falla si el id es inválido", {
  expect_error(leer_estacion("ID_INVENTADO_XXXX"))
})
