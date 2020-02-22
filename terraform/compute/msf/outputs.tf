output "id" {
	value = google_compute_instance.msf.instance_id
}

output "ip" {
	value = google_compute_instance.msf.network_interface.0.access_config.0.nat_ip 
}
