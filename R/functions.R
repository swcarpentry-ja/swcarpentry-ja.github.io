# Helper function to create a locale/lang directory populated with
# files needed for translation
swcja_create_locale <- function(lang) {

  # Create locale/{lang} folder if it does not yet exist
  locale_lang <- glue::glue("locale/{lang}")
  if (!fs::dir_exists(locale_lang)) fs::dir_create(locale_lang)

  # Copy all files needed for building webpage with quarto to locale/{lang}
  file_tibble <-
    list.files() %>%
      tibble::tibble(file = .) %>%
      dplyr::filter(
        stringr::str_detect(
          file,
          "^docs|po|R|renv|.Rprofile|renv.lock|locale|assets",
          negate = TRUE
        )
      ) %>%
      dplyr::mutate(new_loc = glue::glue("locale/{lang}/{file}"))

  purrr::walk2(
    file_tibble$file,
    file_tibble$new_loc,
    ~fs::file_copy(.x, .y, overwrite = TRUE))
}