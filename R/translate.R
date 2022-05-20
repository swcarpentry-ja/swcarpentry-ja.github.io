library(dovetail)
library(quarto)

source("R/functions.R")

# Create ./locale/{lang} containing files needed for translation
if (fs::dir_exists("local/en")) fs::dir_delete("locale/en") # start clean
create_locale("en")

# Translate md files
translate_md(
  md_in = "index.qmd",
  po = "po/en/index.po",
  md_out = "locale/en/index.qmd")

# Render translated webpage
quarto_render(execute_dir = "locale/en", as_job = FALSE)