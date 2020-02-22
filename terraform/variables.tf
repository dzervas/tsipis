variable "config" {
	type = map
	description = "Providers config"
	default = {
		# Global
		project = "tsipis"
		domain = "example.com"

		# Google
		google_region = "us-central1"
		google_zone = "us-central1-c"
	}
}

variable "ssh_keys" {
	type = map
	description = "SSH keys to use on machines"
	# Example:
	# {
	# user: file("~/.ssh/id_rsa.pub")
	# user2: "thisisansshkey"
	# }
}
