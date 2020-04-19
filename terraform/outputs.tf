output "google_ip" {
	value = google_compute_instance.tsipis.network_interface.0.access_config.0.nat_ip
}

# To retrieve Heroku config_vars, you need this hack
data "heroku_app" "tsipis" {
	name = heroku_app.tsipis.name
  	depends_on = [ heroku_addon.tsipis_db ]
}

output "heroku_db" {
	value = data.heroku_app.tsipis.config_vars.DATABASE_URL
	sensitive = true
}
