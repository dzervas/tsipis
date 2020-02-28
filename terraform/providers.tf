locals {
	heroku_file = file("~/.tsipis/heroku.yml")
	heroku = yamldecode(local.heroku_file)
}

provider "google" {
	credentials = file("~/.tsipis/google.json")
	project = var.config.project
	region = var.config.google_region
	zone = var.config.google_zone
}

provider "heroku" {
	email = local.heroku.email
	api_key = local.heroku.api_key
}
