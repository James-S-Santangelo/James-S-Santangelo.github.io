# frozen_string_literal: true

# Warns at build time when _data/publication-links.yml has a key that isn't a
# citation key in _data/publications.bib. Paperpile can change a paper's key when
# its metadata changes (e.g. a corrected year), which silently orphans its links.
# The warning shows in `jekyll serve` / `jekyll build` output and in the CI log.

Jekyll::Hooks.register :site, :post_read do |site|
  links = site.data["publication-links"]
  next unless links.is_a?(Hash)

  bib_path = site.in_source_dir("_data", "publications.bib")
  next unless File.exist?(bib_path)

  bib_keys = File.read(bib_path).scan(/^@\w+\s*\{\s*([^,\s]+)\s*,/).flatten
  (links.keys - bib_keys).each do |key|
    Jekyll.logger.warn "publication-links:",
                       "'#{key}' is not a citation key in publications.bib " \
                       "(renamed in Paperpile?); its links won't show"
  end
end
