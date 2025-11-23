# Resumen estadistico de temperatura por estacion

Calcula media, desvio estandar, maxima y minima de temperatura para una
o mas estaciones. Puede funcionar en dos modos:

1.  Usando datasets internos (`datos_lista`), ideal para examples y
    tests.

2.  Descargando o leyendo archivos reales mediante
    [`leer_estacion()`](https://ezequielpiseri.github.io/meteopisa/reference/leer_estacion.md).

## Usage

``` r
tabla_resumen_temperatura(ids_estaciones = NULL, datos_lista = NULL)
```

## Arguments

- ids_estaciones:

  Vector opcional de IDs de estaciones. Se usa si `datos_lista` es NULL.

- datos_lista:

  Lista opcional de data frames ya cargados, con nombres
  correspondientes a los IDs de estacion.

## Value

Un tibble en formato largo con columnas: `id`, `Tipo`, `Temperatura`.

## Examples

``` r
# Usando el dataset interno (modo recomendado para examples)
data("NH0472")

tabla_resumen_temperatura(
  datos_lista = list(estacion_NH0472 = NH0472)
)
#> Resumen generado correctamente.
#> # A tibble: 4 × 3
#>   id              Tipo   Temperatura
#>   <chr>           <chr>        <dbl>
#> 1 estacion_NH0472 Media        18.0 
#> 2 estacion_NH0472 Desvio        5.94
#> 3 estacion_NH0472 Maxima       34.8 
#> 4 estacion_NH0472 Minima        0.55
```
