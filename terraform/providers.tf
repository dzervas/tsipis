locals {
	google_project = jsondecode(data.pass_password.google.full).project_id
}

provider "pass" {
	refresh_store = true
}

provider "google" {
	credentials = data.pass_password.google.full
	project = local.google_project
	region = var.config.google_region
	zone = var.config.google_zone
}

provider "heroku" {
	api_key = data.pass_password.heroku.password
	email = data.pass_password.heroku.data.email
}
