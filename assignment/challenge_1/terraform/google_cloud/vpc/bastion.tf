// Dedicated service account for the Bastion instance
resource "google_service_account" "bastion" {
  account_id   = format("%s-bastion-sa", var.cluster_name)
  display_name = "Bastion SA"
}


// The user-data script on Bastion instance provisioning
data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt-get update -y
  sudo apt-get install -y tinyproxy kubectl git postgresql-client
  sudo curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sudo bash
  EOF

}

// The Bastion Host
resource "google_compute_instance" "bastion" {
  name = "bastion"
  machine_type = "g1-small"
  zone = var.zones[0]
  project = var.project_id
  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = data.template_file.startup_script.rendered

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.name
    }


  // Allow the instance to be stopped by terraform when updating configuration
  allow_stopping_for_update = true

  service_account {
    email = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin-2fa = "TRUE"
    enable-oslogin     = "TRUE"
  }

  depends_on = [
    google_service_account.bastion
  ]
}

/*****************************************
  Ops Bastion Firewall
 *****************************************/
resource "google_compute_firewall" "bastion-allow-ssh" {
  name    = "${var.cluster_name}-allow-ingress-ssh-bastion"
  network = google_compute_network.network.name
  direction = "INGRESS"
  priority = 1000

  allow {
    ports    = [22, 8888]
    protocol = "tcp"
  }

  source_ranges = values(var.bastion_access_ips)

  target_tags = ["bastion"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}