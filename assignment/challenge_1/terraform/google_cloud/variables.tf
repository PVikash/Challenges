variable "project_id" {
  description = "The project id to deploy Jenkins on GKE"
}

variable "tf_state_bucket" {
  description = "The name of the cluster to be created"
}

variable "cluster_name" {
  description = "The name of the cluster to be created"
}

variable "region" {
  description = "The GCP region to deploy instances into"
}

variable "zones" {
  description = "The list of GCP zones to deploy gke into"
  default     = ["us-east1-b"]
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-scv"
}

variable "subnet_ip" {
  description = "IP range for the subnet"
  default     = "10.10.10.0/24"
}

variable "bastion_access_ips" {
  description = "IP Ranges allowed to access Bastion"
  default     = {}
}

variable "service_account_iam_roles" {
  type = list

  default = [
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer"
  ]
  description = <<-EOF
  List of the default IAM roles to attach to the service account on the
  GKE Nodes.
  EOF
}


variable "db_username" {
  description = "Postgres default db_username"
  default     = "root"
}