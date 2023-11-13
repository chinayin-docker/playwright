variable "version" {
  default = ""
}

variable "provider" {
  default = ""
}

variable "provider_minor" {
  default = ""
}

variable "repo" {
  default = "chinayin/playwright"
}

group "default" {
  targets = []
}

function "platforms" {
  params = []
  result = ["linux/amd64", "linux/arm64"]
}

variable "registry" {
  default = "docker.io"
}

variable "repository" {
  default = "${registry}/${repo}"
}

target "_all_platforms" {
  platforms = platforms()
}

target "debian-playwright" {
  inherits = ["_all_platforms"]
  context  = "${provider}-${provider_minor}"
  tags     = [
    "${repository}:${version}-${provider}${provider_minor}",
  ]
  args = {
    PLAYWRIGHT_VERSION          = "${version}"
    PLAYWRIGHT_INSTALL_BROWSERS = ""
  }
}

target "debian-playwright-chromium" {
  inherits = ["_all_platforms"]
  context  = "${provider}-${provider_minor}"
  tags     = [
    "${repository}:${version}-chromium-${provider}${provider_minor}",
  ]
  args = {
    PLAYWRIGHT_VERSION          = "${version}"
    PLAYWRIGHT_INSTALL_BROWSERS = "chromium"
  }
}

target "debian-playwright-firefox" {
  inherits = ["_all_platforms"]
  context  = "${provider}-${provider_minor}"
  tags     = [
    "${repository}:${version}-firefox-${provider}${provider_minor}",
  ]
  args = {
    PLAYWRIGHT_VERSION          = "${version}"
    PLAYWRIGHT_INSTALL_BROWSERS = "firefox"
  }
}

target "debian-playwright-webkit" {
  inherits = ["_all_platforms"]
  context  = "${provider}-${provider_minor}"
  tags     = [
    "${repository}:${version}-webkit-${provider}${provider_minor}",
  ]
  args = {
    PLAYWRIGHT_VERSION          = "${version}"
    PLAYWRIGHT_INSTALL_BROWSERS = "webkit"
  }
}
