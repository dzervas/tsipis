variable "config" {
	type = map
	description = "Configuration for the various providers - check main.tf in root"
}

variable "ssh_keys" {
	type = map
	description = "A map containing the user as key and the the ssh key as value"
}
