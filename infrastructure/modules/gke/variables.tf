variable "gke_clusters" {
  type = map(object({
    # vpc_id                   = string
    # subnet_id                = string
    # remove_default_node_pool = bool
    # initial_node_count       = number
    enable_autopilot    = bool
    deletion_protection = bool
    master_auth = object({
      client_certificate_config = object({
        issue_client_certificate = bool
      })
    })
    master_authorized_networks_config = object({
      cidr_blocks = object({
        cidr_block = string
      })
    })
  }))
}