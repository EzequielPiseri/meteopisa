test_that("Dataset NH0472 está disponible y correctamente cargado", {
  data("NH0472", package = "meteopisa")

  # El objeto debe existir
  expect_true(exists("NH0472"))

  # Debe ser un tibble/data.frame
  expect_s3_class(NH0472, "data.frame")

  # Columnas mínimas esperadas
  expect_true(all(c("id", "fecha") %in% colnames(NH0472)))

  # No debe estar vacío
  expect_true(nrow(NH0472) > 0)
})
