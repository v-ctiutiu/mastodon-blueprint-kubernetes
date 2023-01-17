# ================================ DO Managed PostgreSQL =============================== #

output "pgsql_db_host" {
  value = digitalocean_database_connection_pool.mastodon_pg_connection_pool[0].private_host
  description = "DO managed PostgreSQL connection pool host"
}

output "pgsql_db_port" {
  value = digitalocean_database_connection_pool.mastodon_pg_connection_pool[0].port
  description = "DO managed PostgreSQL connection pool port number"
}

output "pgsql_db_name" {
  value = digitalocean_database_connection_pool.mastodon_pg_connection_pool[0].db_name
  description = "DO managed PostgreSQL connection pool database name"
}

# ================================ DO Managed Redis =============================== #

output "redis_db_host" {
  value = digitalocean_database_cluster.mastodon_redis[0].private_host
  description = "DO managed Redis database host"
}

output "redis_db_port" {
  value = digitalocean_database_cluster.mastodon_redis[0].port
  description = "DO managed Redis database port number"
}

# ============================== DO Spaces (S3) =========================== #

output "s3_bucket_name" {
  value = digitalocean_spaces_bucket.mastodon_spaces[0].name
  description = "DO Spaces Mastodon bucket name"
}

output "s3_bucket_region" {
  value = digitalocean_spaces_bucket.mastodon_spaces[0].region
  description = "DO Spaces Mastodon bucket region"
}

output "s3_bucket_endpoint" {
  value = digitalocean_spaces_bucket.mastodon_spaces[0].endpoint
  description = "DO Spaces Mastodon bucket endpoint"
}

# ========================== Managed Domain ============================= #

output "mastodon_domain_name" {
  value = digitalocean_domain.mastodon.name
  description = "DO managed domain name"
}

output "mastodon_domain_tls_certificate_uuid" {
  value = digitalocean_certificate.mastodon.uuid
  description = "DO managed Let's Encrypt certificate ID"
}

# ================================ Kubernetes =============================== #

output "pgsql_auth_secret_name" {
  value = kubernetes_secret.pgsql_auth[0].metadata[0].name
  description = "Kubernetes secret name containing PostgreSQL database password"
}

output "pgsql_auth_secret_key" {
  value = keys(kubernetes_secret.pgsql_auth[0].data)[0]
  description = "Kubernetes secret name key PostgreSQL database password"
}

output "redis_auth_secret_name" {
  value = kubernetes_secret.redis_auth[0].metadata[0].name
  description = "Kubernetes secret name containing Redis database password"
}

output "redis_auth_secret_key" {
  value = keys(kubernetes_secret.redis_auth[0].data)[0]
  description = "Kubernetes secret key containing Redis database password"
}

output "mastodon_k8s_namespace" {
  value = kubernetes_namespace.mastodon.metadata[0].name
  description = "Mastodon Kubernetes namespace"
}
