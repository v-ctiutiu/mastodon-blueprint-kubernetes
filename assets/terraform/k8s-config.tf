resource "kubernetes_namespace" "mastodon" {
  metadata {
    annotations = {
      name = "mastodon"
    }

    labels = {
      part_of = "mastodon"
    }

    name = var.mastodon_k8s_namespace
  }
}

resource "kubernetes_secret" "pgsql_auth" {
  count = var.enable_external_postgresql ? 1 : 0

  metadata {
    name      = var.mastodon_pgsql_auth_secret_name
    namespace = var.mastodon_k8s_namespace

    labels = {
      part_of = "mastodon"
    }
  }

  data = {
    db-password = digitalocean_database_connection_pool.mastodon_pg_connection_pool[0].password
  }

  type = "Opaque"
}

resource "kubernetes_secret" "redis_auth" {
  count = var.enable_external_redis ? 1 : 0

  metadata {
    name      = var.mastodon_redis_auth_secret_name
    namespace = var.mastodon_k8s_namespace

    labels = {
      part_of = "mastodon"
    }
  }

  data = {
    db-password = digitalocean_database_cluster.mastodon_redis[0].password
  }

  type = "Opaque"
}
