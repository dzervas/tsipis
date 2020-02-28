output "id" {
	value = google_compute_instance.metasploit.instance_id
}

output "ip" {
	value = google_compute_instance.metasploit.network_interface.0.access_config.0.nat_ip
}

# To retrieve Heroku config_vars, you need this hack
data "heroku_app" "metasploit" {
	name = heroku_app.metasploit.name
}

output "db" {
	value = data.heroku_app.metasploit.config_vars.DATABASE_URL
	sensitive = true
}
