# R script to translate the website contents from Japanese (JA) to English (EN)
# Actual translation takes place in PO files; everything else is automated

library(dovetail)
library(quarto)
library(gert)
source("R/functions.R")

# The English source files live in ./locale/en, which is itself a git repo
# hosted at
# https://github.com/swcarpentry-ja/en

# Clone the repo if it doesn't already exist
if (!fs::dir_exists("locale/en")) {
  git_clone(
    "https://github.com/swcarpentry-ja/en",
    path = "locale/en")
}

# Sync any changes made to ./locale/en from the remote
git_pull("origin", repo = "locale/en")

# Create ./locale/{lang} containing files needed for translation.
# Copies all untranslated files over to locale/{lang}, overwrites
# any existing translations.
swcja_create_locale("en")

# Copy localized files that don't get translated by PO
fs::file_copy(
  "assets/locale/en/_quarto.yml",
  "locale/en/_quarto.yml",
  overwrite = TRUE
)

# Create / update PO files
create_po(md_in = "index.qmd", po = "po/en/index.po")
create_po(md_in = "links.qmd", po = "po/en/links.po")
create_po(md_in = "quickguide.qmd", po = "po/en/quickguide.po")

# (edit PO files)

# Translate md files
translate_md(
  md_in = "index.qmd",
  po = "po/en/index.po",
  md_out = "locale/en/index.qmd")

translate_md(
  md_in = "links.qmd",
  po = "po/en/links.po",
  md_out = "locale/en/links.qmd")

translate_md(
  md_in = "quickguide.qmd",
  po = "po/en/quickguide.po",
  md_out = "locale/en/quickguide.qmd")

# Optional: render translated webpage for local viewing
quarto_render(execute_dir = "locale/en", as_job = FALSE)

# Commit changes in English translation
git_add("*", repo = "locale/en")
git_commit("Update translations", repo = "locale/en")

# Push to the remote
git_push("origin", repo = "locale/en")