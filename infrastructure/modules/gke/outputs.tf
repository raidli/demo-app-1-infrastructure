output "gke_info" {
  value = {
    for gke_name, gke_module in google_container_cluster.mod_gke :
    gke_name => {
      id              = gke_module.id
    }
  }
}