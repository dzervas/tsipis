provider "google" {
	credentials = file("~/.tsipis/google.json")
	project     = var.project
	region      = var.region
}
