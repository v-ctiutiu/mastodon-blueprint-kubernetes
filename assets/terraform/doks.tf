resource "random_id" "cluster_name" {
  byte_length = 5
}

locals {
  doks_cluster_name = "${var.doks_cluster_name_prefix}-${random_id.cluster_name.hex}"
}

data "digitalocean_kubernetes_versions" "current" {
  version_prefix = var.doks_k8s_version
}

resource "digitalocean_kubernetes_cluster" "mastodon" {
  name    = local.doks_cluster_name
  region  = var.doks_cluster_region
  version = data.digitalocean_kubernetes_versions.current.latest_version

  node_pool {
    name       = var.doks_primary_node_pool["name"]
    size       = var.doks_primary_node_pool["size"]
    node_count = var.doks_primary_node_pool["node_count"]
  }
}

resource "digitalocean_kubernetes_node_pool" "mastodon_extra_node_pool" {
  cluster_id = digitalocean_kubernetes_cluster.mastodon.id
  for_each   = var.doks_additional_node_pools

  name       = each.key
  size       = each.value.size
  node_count = each.value.node_count
}
