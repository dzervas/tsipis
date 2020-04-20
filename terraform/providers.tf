locals {
	google_project = jsondecode(data.pass_password.cloud_admin.data.google_credentials).project_id
  	okteto_config = yamldecode(data.pass_password.cloud_admin.data.okteto_config)
	okteto_namespace = local.okteto_config.contexts.0.context.namespace
}

provider "pass" {
//	refresh_store = true
}

data "pass_password" "cloud_admin" {
	path = "${var.pass_cloud_admin_path}"
}

provider "heroku" {
	api_key = data.pass_password.cloud_admin.data.heroku_api_key
	email = data.pass_password.cloud_admin.data.heroku_email
}

provider "google" {
	credentials = data.pass_password.cloud_admin.data.google_credentials
	project = local.google_project
	region = var.google_region
	zone = var.google_zone
}

provider "kubernetes" {
	load_config_file = "false"

	host = local.okteto_config.clusters.0.cluster.server

	cluster_ca_certificate = base64decode(local.okteto_config.clusters.0.cluster.certificate-authority-data)
	token = local.okteto_config.users.0.user.token
}

provider "helm" {
	kubernetes {
		load_config_file = "false"

		host = local.okteto_config.clusters.0.cluster.server

		cluster_ca_certificate = base64decode(local.okteto_config.clusters.0.cluster.certificate-authority-data)
		token = local.okteto_config.users.0.user.token
	}
}
