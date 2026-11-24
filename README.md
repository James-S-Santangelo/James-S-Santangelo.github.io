# james-s-santangelo.github.io

Source for <https://james-s-santangelo.github.io>, built with
[Jekyll](https://jekyllrb.com) 4.4 and the
[Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) theme (4.28.1),
and deployed to GitHub Pages by GitHub Actions.

## How it's built

| Piece | Where | Notes |
|---|---|---|
| Ruby | 3.4 | Same version locally (Homebrew `ruby@3.4`) and in CI |
| Jekyll | `Gemfile` (`~> 4.4`) | Exact versions pinned in `Gemfile.lock` |
| Theme | `Gemfile` (git tag `4.28.1`) | Not vendored; only overrides live in this repo |
| Build + deploy | `.github/workflows/pages.yml` | Builds every branch/PR; deploys **only** `master` |
| Updates | `.github/dependabot.yml` | Weekly PRs for gems and actions |

## Render the site locally (macOS)

### 1. One-time setup: Ruby 3.4

```bash
xcode-select --install          # compiler + git; skip if already installed
brew install ruby@3.4           # NOT plain `ruby` (that's 4.x; CI and Jekyll test on 3.4)

# ruby@3.4 is keg-only, so put it first on your PATH (zsh is the macOS default shell):
echo 'export PATH="$(brew --prefix ruby@3.4)/bin:$PATH"' >> ~/.zshrc
exec zsh
ruby -v                         # expect ruby 3.4.x
```

macOS's built-in `/usr/bin/ruby` (2.6) is too old. The line above makes sure it
isn't the one used.

### 2. Get the branch and install gems into the repo (no sudo)

```bash
git clone https://github.com/James-S-Santangelo/James-S-Santangelo.github.io.git
cd James-S-Santangelo.github.io
git switch upgrade/mm-4.28-actions        # or whichever branch you're testing

bundle config set --local path vendor/bundle
bundle install
```

### 3. Serve

```bash
bundle exec jekyll serve --livereload
# open http://127.0.0.1:4000 — pages reload as you edit
```

Restart the server after editing `_config.yml` (Jekyll doesn't reload it).

To reproduce the exact production build (HTML compression on, etc.):

```bash
JEKYLL_ENV=production bundle exec jekyll build    # output in _site/
```

### About `Gemfile.lock`

`Gemfile.lock` is committed, so local and CI builds resolve the same gem versions.
It already lists both macOS (`arm64-darwin`, `x86_64-darwin`) and the CI
platform (`x86_64-linux-gnu`). If you ever regenerate it (`bundle update`) and CI
then complains about a missing platform, run
`bundle lock --add-platform x86_64-linux` and commit again.

## "Updated:" dates

Pages using the `single` layout (Research, Publications, Conferences, and any new
ones) show **Updated: Month Year** at the bottom. The date is the last git
**commit** that touched the page, from
[jekyll-last-modified-at](https://github.com/gjtorikian/jekyll-last-modified-at),
so you never set it by hand. Uncommitted edits don't change it until you commit.

Pages built from data files also count those files' commits. List them in
front matter (handled by `_plugins/last_modified_at_sources.rb`):

```yaml
last_modified_at_sources:
  - _data/journal-articles.yaml
```

Publications and Conferences already do this. The date format is `date_format`
in `_config.yml`. CI checks out the full git history (`fetch-depth: 0`) so the
dates are real.

## Deploying

1. **One-time repo setting:** *Settings → Pages → Build and deployment → Source:*
   **GitHub Actions**. Do this **before** merging to `master`; the old
   "Deploy from a branch" builder can't build this configuration.
2. Merge into `master`. The workflow builds and deploys automatically. Progress
   is in the *Actions* tab.

Pushes to any other branch run a test build only, so you can check that the build
passes before merging.

## Updating

- **Theme:** Dependabot should open a PR when a new Minimal Mistakes tag appears.
  To bump by hand, edit the `tag:` in `Gemfile`, then
  `bundle update minimal-mistakes-jekyll`. Then check `_includes/feature_row`
  against the new upstream copy (see below).
- **Everything else:** `bundle update`, then serve locally and check.

## Where the customizations live

The theme isn't copied into this repo. Site-specific changes live in:

- `_config.yml`: site and author settings, sidebar and footer links, skin.
- `assets/css/main.scss`: all style overrides, appended after the theme import.
- `_plugins/last_modified_at_sources.rb`: lets a page's "Updated:" date
  include the data files it's built from.
- `_includes/feature_row`: the only theme template override (clickable teaser
  images with no button). Diff it against upstream when the theme is bumped.
- `_includes/{journal-articles,book-chapters,preprints,educational-resources,invited,contributed}.html`
  with matching `_data/*.yaml`: the publication and talk lists.
- `_data/navigation.yml`: the top navigation.
- `_pages/`: page content.

To override any other theme file, copy it from the theme at the pinned tag
(`bundle info minimal-mistakes-jekyll --path` shows where it is installed) into
the same relative path here, then edit it.
