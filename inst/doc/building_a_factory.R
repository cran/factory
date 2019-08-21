## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(factory)

## ----function to generalize----------------------------------------------
my_scale_color <- function(discrete = TRUE, reverse = FALSE, ...) {
  my_palette <- c(
    "#772277", "#333388", "#1144aa", "#55aa11", 
    "#f40000", "#f47a00", "#ffe314"
  )
  if (reverse) {
    my_palette <- rev(my_palette)
  }
  pal <- colorRampPalette(my_palette, ...)
  
  if (discrete) {
    ggplot2::discrete_scale(
      aesthetics = "colour",
      scale_name = "my_color_scale", 
      palette = pal,
      ...
    )
  } else {
    ggplot2::scale_color_gradientn(colors = pal(256),)
  }
}

ggplot2::ggplot(mtcars) + 
  ggplot2::aes(x = mpg, y = cyl, color = factor(gear)) +
  ggplot2::geom_point() + 
  my_scale_color()

## ----genericized function------------------------------------------------
my_scale_color_generic <- function(discrete = TRUE, reverse = FALSE, ...) {
  my_palette <- this_palette
  if (reverse) {
    my_palette <- rev(my_palette)
  }
  pal <- colorRampPalette(my_palette, ...)
  
  if (discrete) {
    ggplot2::discrete_scale(
      aesthetics = "colour",
      scale_name = this_scale_name, 
      palette = pal,
      ...
    )
  } else {
    ggplot2::scale_color_gradientn(colors = pal(256),)
  }
}

## ----sample factory------------------------------------------------------
my_scale_color_factory <- build_factory(
  fun = my_scale_color_generic,
  this_palette,
  this_scale_name = "my_color_scale"
)

## ----using the factor----------------------------------------------------
my_scale_color_factory(
  this_palette = c(
    "#772277", "#333388", "#1144aa", "#55aa11", 
    "#f40000", "#f47a00", "#ffe314"
  )
)

