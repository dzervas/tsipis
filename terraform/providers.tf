locals {
	cloud_admin = yamldecode(data.pass_password.cloud_admin.full)
	google_project = jsondecode(local.cloud_admin.google_credentials).project_id
}

provider "pass" {
//	refresh_store = true
}

data "pass_password" "cloud_admin" {
	path = "${var.pass_cloud_admin_path}"
}

provider "heroku" {
	api_key = local.cloud_admin.heroku_api_key
	email = local.cloud_admin.heroku_email
}

provider "google" {
	credentials = local.cloud_admin.google_credentials
	project = local.google_project
	region = var.google_region
	zone = var.google_zone
}
