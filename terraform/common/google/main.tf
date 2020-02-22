resource "random_id" "bucket_images" {
	byte_length = 4
	prefix      = "images-"
	keepers     = {
		project  = var.project,
		region   = var.region,
		zone     = var.zone
	}
}

resource "google_storage_bucket" "images" {
	name     = random_id.bucket_images.dec
	location = var.region
	storage_class = "STANDARD"
}
