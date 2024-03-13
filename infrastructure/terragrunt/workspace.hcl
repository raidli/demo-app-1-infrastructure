locals {
  // Change this workspace_suffix to non-empty string if you want to test with personal state files and objects.
  // Don't forget to use a hyphen for a separator e.g. "-{username}"
  workspace_suffix = "-ephemeral"
  project_id     = get_env("GKE_PROJECT_ID", "")
  gke_acl_cidr     = get_env("GKE_ACL_CIDR", "")
  credentials      = get_env("GKE_CREDENTIALS_PATH", "")
}