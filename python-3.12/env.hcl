variable "version" {
  default = "1.52.0"
}
variable "provider" {
  default = "python"
}
variable "provider_minor" {
  default = "3.12"
}

group "default" {
  targets = ["debian-playwright", "debian-playwright-chromium", "debian-playwright-firefox", "debian-playwright-webkit"]
}
