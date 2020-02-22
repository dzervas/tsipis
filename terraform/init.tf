module "google" {
	source = "./common/google"

	project = var.project
	region = var.google_region
	zone = var.google_zone
}
