resource "google_container_cluster" "mod_gke" {
  for_each            = var.gke_clusters
  name                = each.key
  enable_autopilot    = each.value.enable_autopilot
  deletion_protection = each.value.deletion_protection

  master_auth {
    client_certificate_config {
      issue_client_certificate = each.value.master_auth.client_certificate_config.issue_client_certificate
    }
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = each.value.master_authorized_networks_config.cidr_blocks.cidr_block
    }
  }
}