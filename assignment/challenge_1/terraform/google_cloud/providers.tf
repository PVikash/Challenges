terraform {
  required_version = ">= 0.12"
  backend "gcs" {
    bucket = var.tf_state_bucket
    prefix = "tf/gcp/state/resources"
  }
}

provider "google" {
  version = "2.18.0"
  project = var.project_id
  region = var.region
}

provider "template" {
  version = "~> 2.1"
}