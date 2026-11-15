source "https://rubygems.org"

# Jekyll itself. Built by GitHub Actions (.github/workflows/pages.yml),
# so we are not limited to the github-pages gem's Jekyll 3.10.
gem "jekyll", "~> 4.4"

# Theme: Minimal Mistakes, pinned to a release tag. Dependabot opens a PR
# when a new tag is published; bump manually by editing the tag and running
# `bundle update minimal-mistakes-jekyll`.
gem "minimal-mistakes-jekyll",
    git: "https://github.com/mmistakes/minimal-mistakes.git",
    tag: "4.28.1"

# Plugins listed in _config.yml. They are also runtime dependencies of the
# theme, but are declared here so Dependabot tracks them directly.
# Exact versions are pinned in Gemfile.lock.
group :jekyll_plugins do
  gem "jekyll-include-cache"
  gem "jekyll-sitemap"
  gem "jekyll-feed"
end
