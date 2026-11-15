# james-s-santangelo.github.io

Source for <https://james-s-santangelo.github.io>, built with
[Jekyll](https://jekyllrb.com) 4.4 and the
[Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) theme (4.28.1),
and deployed to GitHub Pages by GitHub Actions.

## How it's built

| Piece | Where | Notes |
|---|---|---|
| Ruby | 3.4 | Same version locally and in CI |
| Jekyll | `Gemfile` (`~> 4.4`) | Exact versions pinned in `Gemfile.lock` |
| Theme | `Gemfile` (git tag `4.28.1`) | Not vendored; only overrides live in this repo |
| Build + deploy | `.github/workflows/pages.yml` | Builds every branch/PR; deploys **only** `master` |
| Updates | `.github/dependabot.yml` | Weekly PRs for gems and actions |

## Render the site locally

### 1. Install Ruby 3.4, Bundler, and a compiler (one time)

**CachyOS / Arch**

```bash
sudo pacman -S --needed ruby ruby-stdlib ruby-bundler base-devel git
ruby -v      # expect 3.4.x
```

**Any distro, version-managed (alternative)**: install [mise](https://mise.jdx.dev),
then `mise use -g ruby@3.4`.

### 2. Install the gems into the repo (no sudo, nothing system-wide)

```bash
git clone https://github.com/James-S-Santangelo/James-S-Santangelo.github.io.git
cd James-S-Santangelo.github.io
git switch upgrade/mm-4.28-actions        # or whichever branch you're testing

bundle config set --local path vendor/bundle
bundle install
```

The first install fetches the theme from GitHub and compiles a few native
extensions; that takes a minute or two.

### 3. Serve

```bash
bundle exec jekyll serve --livereload
# open http://127.0.0.1:4000 — pages reload as you edit
```

Restart the server after editing `_config.yml` (Jekyll doesn't reload it).

To reproduce the exact production build (HTML compression on, etc.):

```bash
JEKYLL_ENV=production bundle exec jekyll build
# output in _site/
```

### 4. Commit the lockfile (first time only)

`bundle install` writes `Gemfile.lock`. Commit it so CI builds with exactly the
gem versions you tested:

```bash
git add Gemfile.lock
git commit -m "Add Gemfile.lock"
git push
```

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
- `_includes/feature_row`: the only theme template override (clickable teaser
  images with no button). Diff it against upstream when the theme is bumped.
- `_includes/{journal-articles,book-chapters,preprints,educational-resources,invited,contributed}.html`
  with matching `_data/*.yaml`: the publication and talk lists.
- `_data/navigation.yml`: the top navigation.
- `_pages/`: page content.

To override any other theme file, copy it from the theme at the pinned tag
(`bundle info minimal-mistakes-jekyll --path` shows where it is installed) into
the same relative path here, then edit it.
