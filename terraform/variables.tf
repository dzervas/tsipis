# Required variables
variable "ssh_keys" {
	type = map
	description = "Map of username: SSH key to use on machines"
	# Example:
	# {
	# user: file("~/.ssh/id_rsa.pub")
	# user2: "thisisansshkey"
	# }
}

# Sane defaults - but take a look
variable "internal_tld" {
	type = string
	description = "VPN-internal TLD to use for machines & services"
	default = "vpn"
}

variable "pass_cloud_admin_path" {
	type = string
	description = "Path to (go)pass cloud admin secrets (API tokens, etc.)"
	default = "tsipis/cloud-admin"
}

variable "project_name" {
	type = string
	description = "Project name used on all providers"
	default = "tsipis"
}

variable "google_region" {
	type = string
	default = "us-central1"
}

variable "google_zone" {
	type = string
	default = "us-central1-c"
}

variable "heroku_region" {
	type = string
	default = "us"
}
