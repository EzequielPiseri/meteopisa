# Grafico de temperatura media mensual por estacion

Calcula la temperatura media mensual por estacion y genera un grafico
usando ggplot2.

## Usage

``` r
grafico_temperatura_mensual(datos, colores = NULL, titulo = "Temperatura")
```

## Arguments

- datos:

  Tibble con columnas: id, fecha (Date), temperatura_abrigo_150cm.

- colores:

  Vector de colores opcional.

- titulo:

  Titulo del grafico.

## Value

Un objeto ggplot2.

## Examples

``` r
# Cargar datos internos
data("NH0472")

# Graficar la temperatura mensual
grafico_temperatura_mensual(NH0472)
#> Se seleccionaron 1 colores aleatorios.
#> Grafico generado correctamente.

```
