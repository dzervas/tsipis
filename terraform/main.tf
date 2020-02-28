module "metasploit" {
	source = "./compute/metasploit"

	config = var.config
	ssh_keys = var.ssh_keys
}
