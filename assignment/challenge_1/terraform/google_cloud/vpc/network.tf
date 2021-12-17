
resource "google_compute_network" "network" {

  name                    = format("%s-network", var.cluster_name)
  project                 = var.project_id
  auto_create_subnetworks = false
  depends_on = [
  ]
}

locals {
  network = google_compute_network.network
}
