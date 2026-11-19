# Gaia runtime image

One recipe (`Dockerfile`) builds the images Gaia, its CI and its test containers run on: PHP, Apache, Phalcon and
the extensions Gaia needs. It replaces the MySQL-era recipe that used to be here (`mileschou/phalcon:7.4`,
pdo_mysql, PHPUnit 5.7) and the hand-built `rananoman/gaia:env-dev`.

| Stack | Args file | PHP | Phalcon | psr | xdebug | xhprof | mongodb | PHPUnit | Base |
|---|---|---|---|---|---|---|---|---|---|
| `current` | `current.args` | 7.4.21 | 4.1.2 | 1.1.0 | 3.1.5 | 2.3.7 | 1.15.3 | 9.6.21 | `php:7.4.21-apache-buster` (Debian 10, apt from archive.debian.org) |
| `next` | `next.args` | 8.5.12 | 5.23.0 | none | 3.5.3 | 2.3.10 | none | 11.5.0 | `php:8.5.12-apache` |

Both install pdo_pgsql, imagick, zip, exif, mbstring, curl, xml, composer 2, PHPUnit and Apache with mod_rewrite.

## Published images

`.github/workflows/gaia-env.yml` builds both stacks, checks their PHP and Phalcon versions, and on a push to `dev`
(or a manual run) publishes them to `ghcr.io/projects4me/gaia-env`. Pull requests only build and check.

| Tag | Moves? | Use it for |
|---|---|---|
| `current`, `next` | yes, on every publish | trying things out |
| `7.4.21-phalcon4.1.2`, `8.5.12-phalcon5.23.0` | when the recipe changes without a version bump | Dockerfiles and CI |
| `<version>-<commit>`, e.g. `8.5.12-phalcon5.23.0-1a2b3c4` | never | pinning an exact build (deploys, rollback) |

The images are public: `docker pull ghcr.io/projects4me/gaia-env:next` needs no login.

## Change a version

Edit the stack's `.args` file (one `KEY=VALUE` build arg per line). The published version tag is read from
`BASE_IMAGE` (the PHP version) and `PHALCON_VERSION`. Open a pull request into `dev`; the workflow builds and checks
it, and merging publishes it.

## Build locally

```
gaia/env/build.sh [current|next|all]   # default: all; tags gaia-env:current / gaia-env:next
```

## Check

```
docker run --rm ghcr.io/projects4me/gaia-env:next php -v              # PHP 8.5.12
docker run --rm ghcr.io/projects4me/gaia-env:next php --ri phalcon    # Version => 5.23.0
docker run --rm ghcr.io/projects4me/gaia-env:current php -v           # PHP 7.4.21
docker run --rm ghcr.io/projects4me/gaia-env:current php --ri phalcon # Version => 4.1.2
```
