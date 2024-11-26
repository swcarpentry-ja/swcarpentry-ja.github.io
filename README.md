# website

Website for The Carpentries in Japan

## Translation

The website uses [babelquarto](https://docs.ropensci.org/babelquarto/) to maintain translations.

To locally render and view the translated website, run the following commands in R:

```r
library(babelquarto)
library(servr)

render_website()
httw("docs")
```

Alternatively, source the `render_serve.R` [file](R/render_serve.R).

## License

swcarpentry-ja.github.io is licensed under a
[Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
