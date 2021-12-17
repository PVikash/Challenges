
resource "google_compute_subnetwork" "subnetwork" {
  name          = format("%s-subnet", var.cluster_name)
  project       = var.project_id
  network       = network.self_link
  region        = var.region
  ip_cidr_range = var.subnet_ip

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = format("%s-pod-range", var.cluster_name)
    ip_cidr_range = "10.2.0.0/16"
  }

  secondary_ip_range {
    range_name    = format("%s-svc-range", var.cluster_name)
    ip_cidr_range = "10.3.0.0/20"
  }
}

locals {
  subnet = google_compute_subnetwork.subnetwork
}
