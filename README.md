# docker-images

Docker images for the Projects4Me services.

| Folder | Image | Notes |
|---|---|---|
| `gaia/env` | `ghcr.io/projects4me/gaia-env` (`current`: PHP 7.4 / Phalcon 4, `next`: PHP 8.5 / Phalcon 5) | Gaia runtime; published by `.github/workflows/gaia-env.yml`. See `gaia/env/README.md`. |
| `gaia` | | Older Gaia app image and compose file on `rananoman/gaia:env-dev`. |
| `prometheus/env`, `prometheus` | | Prometheus (Ember) images. |
