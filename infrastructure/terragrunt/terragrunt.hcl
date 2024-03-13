locals {
  # Automatically load workspace variables
  workspace_vars = read_terragrunt_config(find_in_parent_folders("workspace.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  region_name      = local.region_vars.locals.region_name
  env_name         = local.environment_vars.locals.env_name
  module_name      = basename(path_relative_to_include())
  workspace_suffix = local.workspace_vars.locals.workspace_suffix
  project_id       = local.workspace_vars.locals.project_id
  credentials      = local.workspace_vars.locals.credentials
}



generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.19.0"
    }
  }
}
EOF
}

generate "provider" {

  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  credentials = "${local.credentials}"
  region     = "${local.region_name}"
  project = "${local.project_id}"
}
EOF
}