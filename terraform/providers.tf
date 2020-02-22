provider "google" {
	credentials = file("~/.tsipis/google.json")
	project = var.config.project
	region = var.config.google_region
	zone = var.config.google_zone
}
