resource "google_compute_instance" "msf" {
	name = "msf"
	machine_type = "f1-micro"
	allow_stopping_for_update = true

	project = var.config.project
	zone = var.config.google_zone

	hostname = "msf.${var.config.domain}"

	metadata = {
		ssh-keys = join("\n", [for user, key in var.ssh_keys : "${user}:${key}"])
	}

	boot_disk {
		initialize_params {
			image = "gce-uefi-images/ubuntu-1804-lts"
			# Google Free is up to 30GB. We better use them all.
			size = 30
		}
	}

	network_interface {
		# A default network is created for all GCP projects
		network = "default"
		access_config {}
	}

	shielded_instance_config {
		enable_secure_boot = true
	}
}
