Playwright Base Image
=================

[![Docker Image CI](https://github.com/chinayin-docker/playwright/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/chinayin-docker/playwright/actions/workflows/ci.yml)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/chinayin/playwright?sort=semver)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/chinayin/playwright?sort=semver)
![Docker Pulls](https://img.shields.io/docker/pulls/chinayin/playwright)

Playwright is a framework for Web Testing and Automation. It allows testing Chromium, Firefox and WebKit with a single
API.

Usage
------------

You can use the image directly, e.g.

```bash
docker run --rm -it chinayin/playwright:1.41.2
docker run --rm -it chinayin/playwright:1.41.2-python3.11
docker run --rm -it chinayin/playwright:1.41.2-chromium--python3.11
docker run --rm -it chinayin/playwright:1.41.2-firefox--python3.11
docker run --rm -it chinayin/playwright:1.41.2-webkit--python3.11
docker run --rm -it chinayin/playwright:1.41.2-node18
```

The images are built daily and have the security release enabled, so will contain any security updates released more
than 24 hours ago.

You can also use the images as a base for your own Dockerfile:

```bash
FROM chinayin/playwright:1.41.2
```
