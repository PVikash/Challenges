
resource "google_compute_firewall" "default-denyall-ingress" {
  name    = "${var.cluster_name}-deny-ingress-internet"
  network = network.name
  direction = "INGRESS"
  priority = 65000

  deny {
    ports    = []
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "default-denyall-egress" {
  name    = "${var.cluster_name}-deny-egress-internet"
  network = network.name
  direction = "EGRESS"
  priority = 65000

  deny {
    ports    = []
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "default-allow-http-egress" {
  name    = "${var.cluster_name}-allow-egress-http-internet"
  network = network.name
  direction = "EGRESS"
  priority = 64000

  allow {
    ports    = []
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow-internal-ingress" {
  name    = "${var.cluster_name}-allow-ingress-withinvpc"
  network = network.name
  allow {
    ports    = []
    protocol = "all"
  }
  source_ranges = [
    "${var.subnet_ip}",
  ]
}

resource "google_compute_firewall" "allow-internal-egress" {
  name    = "${var.cluster_name}-allow-egress-withinvpc"
  network = network.name

  direction = "EGRESS"

  allow {
    ports    = []
    protocol = "all"
  }
  destination_ranges = [
    "${var.subnet_ip}",
  ]
}

resource "google_compute_firewall" "default-allow-iap-ingress" {
  name    = "${var.cluster_name}-allow-ingress-iap"
  network = network.name
  direction = "INGRESS"
  priority = 20000

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

locals {
  subnet = google_compute_subnetwork.subnetwork
}
