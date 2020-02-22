module "msf" {
	source = "./compute/msf"

	config = var.config
	ssh_keys = var.ssh_keys
}
