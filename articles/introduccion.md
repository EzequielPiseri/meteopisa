# Introduccion a meteopisa

## Introduccion

El paquete **meteopisa** provee funciones para trabajar con datos
meteorologicos: lectura de estaciones, resumen de temperatura y
visualizaciones rapidas.

En esta vineta se muestra como utilizar el paquete usando unicamente los
**datasets internos incluidos** en `meteopisa`. Esto garantiza que todo
el codigo funcione:

- sin carpetas externas
- sin necesidad de Internet
- en cualquier computadora
- durante R CMD check

------------------------------------------------------------------------

## Cargar el paquete

``` r
library(meteopisa)
```

------------------------------------------------------------------------

## Datos incluidos en el paquete

``` r
data("NH0472")
head(NH0472)
```

------------------------------------------------------------------------

## Leer datos con `leer_estacion()`

``` r
archivo_temp <- tempfile(fileext = ".csv")
write.csv(NH0472, archivo_temp, row.names = FALSE)
datos_leidos <- leer_estacion("estacion_NH0472", archivo_temp)
head(datos_leidos)
```

------------------------------------------------------------------------

## Resumen de temperatura

``` r
archivo_temp <- tempfile(fileext = ".csv")
write.csv(NH0472, archivo_temp, row.names = FALSE)

ids <- c("estacion_NH0472")

leer_estacion_local <- function(id, ruta) NH0472

tabla_resumen_temperatura_local <- function(ids_estaciones) {
  lista <- list()
  for (id in ids_estaciones) {
    lista[[id]] <- NH0472
    lista[[id]]$id <- id
  }
  dplyr::bind_rows(lista) |>
    dplyr::group_by(id) |>
    dplyr::summarise(
      Maxima = max(temperatura_abrigo_150cm, na.rm = TRUE),
      Minima = min(temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )
}

resumen <- tabla_resumen_temperatura_local(ids)
resumen
```

------------------------------------------------------------------------

## Grafico mensual

``` r
library(ggplot2)
grafico_temperatura_mensual(NH0472)
```
