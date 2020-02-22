output "region" {
	value        = var.region
	description  = "Datacenter Region"
}

output "zone" {
	value        = var.zone
	description  = "Datacenter Zone"
}

output "project" {
	value        = var.project
	description  = "Project name"
}

output "bucket_images" {
	value        = google_storage_bucket.images.name
	description  = "Name of the images bucket"
}
