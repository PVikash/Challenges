// Credentials for private cluster
output "get_credentials" {
  description = "Gcloud get-credentials command"
  value       = format("gcloud container clusters get-credentials --project %s --zone %s --internal-ip %s-priv-cluster", var.project_id, var.zones[0], var.cluster_name)
}

// Bastion proxy command
output "bastion_proxy" {
  description = "Gcloud compute ssh to the bastion host command"
  value       = format("gcloud compute ssh %s --project %s --zone %s -- -L8888:127.0.0.1:8888", google_compute_instance.bastion.name, var.project_id, google_compute_instance.bastion.zone)
}

// Postgres DB username.
output "postgres_user" {
  description = "The Cloud SQL Instance User name"
  value       = google_sql_user.default.name
}

// Postgres DB password.
output "postgres_pass" {
  sensitive   = true
  description = "The Cloud SQL Instance Password (Generated)"
  value       = google_sql_user.default.password
}

// Ops Static IP.
output "ops_static_ip" {
  description = "Static IP for Ops"
  value       = google_compute_global_address.op_static_ip.address
}