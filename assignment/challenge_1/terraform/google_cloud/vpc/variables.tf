variable "project_id" {
  description = "The project id to deploy Jenkins on GKE"
}

variable "cluster_name" {
  description = "The name of the cluster to be created"
}

variable "region" {
  description = "The GCP region to deploy instances into"
}

variable "subnet_ip" {
  description = "IP range for the subnet"
  default     = "10.10.10.0/24"
}