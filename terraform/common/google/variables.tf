variable "region" {
	type         = string
	description  = "Datacenter Region - Always Free is only available in us-east1, us-west1, and us-central1"
	default      = "us-central1"
}

variable "zone" {
	type         = string
	description  = "Datacenter Zone - Must be inside Region"
	default      = "us-central1-c"
}

variable "project" {
	type         = string
	description  = "Project name"
	default      = "tsipis"
}
