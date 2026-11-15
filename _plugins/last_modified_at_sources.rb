# frozen_string_literal: true

# Extends jekyll-last-modified-at.
#
# That plugin sets page.last_modified_at from the git history of the page's own
# file. Some pages are rendered mostly from other files (e.g. the publications
# list comes from _data/journal-articles.yaml), so editing those wouldn't move
# the page's "Updated:" date. A page can list those files in its front matter:
#
#   last_modified_at_sources:
#     - _data/journal-articles.yaml
#
# and its date becomes the most recent commit touching the page OR any listed file.
# Paths are relative to the site root. Missing files produce a build warning.

Jekyll::Hooks.register :pages, :post_init, priority: :low do |page|
  sources = Array(page.data["last_modified_at_sources"])
  next if sources.empty?

  unless defined?(Jekyll::LastModifiedAt::Determinator)
    Jekyll.logger.warn "last_modified_at_sources:", "jekyll-last-modified-at is not loaded; ignoring"
    next
  end

  site = page.site
  format = site.config.dig("last-modified-at", "date-format")

  times = ([page.path] + sources).filter_map do |rel|
    unless File.exist?(site.in_source_dir(rel))
      Jekyll.logger.warn "last_modified_at_sources:", "#{rel} (listed in #{page.path}) not found"
      next
    end
    Jekyll::LastModifiedAt::Determinator.new(site.source, rel, format).last_modified_at_time
  end

  page.data["last_modified_at"] = times.max unless times.empty?
end
