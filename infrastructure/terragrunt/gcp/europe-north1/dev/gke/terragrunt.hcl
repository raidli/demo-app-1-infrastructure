include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//infrastructure/modules/gke"
}

include "workspace" {
  path   = find_in_parent_folders("workspace.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

locals {
  workspace_suffix = include.workspace.locals.workspace_suffix
  region_name      = include.region.locals.region_name
  env_name         = include.env.locals.env_name
  module_name      = basename(path_relative_to_include("root"))
  project_id     = include.workspace.locals.project_id
  gke_acl_cidr     = include.workspace.locals.gke_acl_cidr
}


inputs = {
  gke_clusters = {
    "${local.module_name}-${local.env_name}-${local.project_id}${local.workspace_suffix}" = {
      enable_autopilot                  = true
      deletion_protection               = false
      master_auth                       = { client_certificate_config = { issue_client_certificate = true } }
      master_authorized_networks_config = { cidr_blocks = { cidr_block = local.gke_acl_cidr } }
    }
  }
}