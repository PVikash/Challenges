resource "google_sql_database_instance" "ops" {
  project          = var.project_id
  name             = format("%s-postgres", var.cluster_name)
  database_version = "POSTGRES_12"
  region           = var.region

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier              = "db-g1-small"
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = "false"
      private_network = google_compute_network.network.self_link

      authorized_networks {
         name  = "subnet"
         value = var.subnet_ip

       }
    }

    disk_autoresize = false
    disk_size       = "50"
    disk_type       = "PD_SSD"
    pricing_plan    = "PER_USE"

    location_preference {
      zone = var.zones[0]
    }
  }

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "google_sql_database" "default" {
  name       = "default"
  project    = var.project_id
  instance   = google_sql_database_instance.ops.name
  collation  = "en_US.UTF8"
  depends_on = [google_sql_database_instance.ops]
}

resource "random_id" "user-password" {
  keepers = {
    name = google_sql_database_instance.ops.name
  }

  byte_length = 8
  depends_on  = [google_sql_database_instance.ops]
}

resource "google_sql_user" "default" {
  name       = var.db_username
  project    = var.project_id
  instance   = google_sql_database_instance.ops.name
  password   = random_id.user-password.hex
  depends_on = [google_sql_database_instance.ops]
}