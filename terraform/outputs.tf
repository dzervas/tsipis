output "metasploit_ip" {
	value = module.metasploit.ip
}

output "metasploit_db" {
	value = module.metasploit.db
	sensitive = true
}
