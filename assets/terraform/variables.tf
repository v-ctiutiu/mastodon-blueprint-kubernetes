# ===================== DOKS CONFIG VARS ======================= #

variable "doks_cluster_name_prefix" {
  type        = string
  default     = "mastodon-k8s"
  description = "DOKS cluster name prefix value (a random suffix is appended automatically)"
}

variable "doks_k8s_version" {
  type        = string
  default     = "1.25"
  description = "DOKS Kubernetes version"
}

variable "doks_cluster_region" {
  type        = string
  default     = "nyc1"
  description = "DOKS region name"
}

variable "doks_primary_node_pool" {
  type = map
  default = {
    name       = "mastodon-default"
    node_count = 2
    size       = "s-2vcpu-4gb"
  }
  description = "DOKS cluster primary node pool configuration"
}

variable "doks_additional_node_pools" {
  type = map
  default = {}
  description = "DOKS cluster additional node pool configuration"
}

# =============== MASTODON CONFIG VARS ================== #

variable "mastodon_k8s_namespace" {
  type        = string
  default     = "mastodon"
  description = "Kubernetes namespace to use for the Mastodon Helm release"
}

variable "mastodon_pgsql_auth_secret_name" {
  type = string
  default = "pgsql-auth"
  description = "Kubernetes secret name containing PostgreSQL password"
}

variable "mastodon_redis_auth_secret_name" {
  type = string
  default = "redis-auth"
  description = "Kubernetes secret name containing Redis password"
}

variable "mastodon_web_domain" {
  type = string
  description = "Sets the domain name for your Mastodon instance (REQUIRED)"
}

# =============== EXTERNAL POSTGRES CONFIG VARS (DO MANAGED) ================= #

variable "enable_external_postgresql" {
  type        = bool
  default     = false
  description = "Enable external PostgreSQL cluster (DO managed)"
}

variable "pg_cluster_name" {
  type        = string
  default     = "pg-mastodon"
  description = "DO managed PostgreSQL cluster name"
}

variable "pg_cluster_version" {
  type        = string
  default     = "14"
  description = "DO managed PostgreSQL engine version"
}

variable "pg_cluster_region" {
  type        = string
  default     = "nyc1"
  description = "DO managed PostgreSQL cluster region"
}

variable "pg_cluster_size" {
  type        = string
  default     = "db-s-1vcpu-1gb"
  description = "DO managed PostgreSQL cluster worker nodes size"
}

variable "pg_cluster_node_count" {
  type        = number
  default     = 1
  description = "DO managed PostgreSQL cluster node count"
}

variable "pg_cluster_db_name" {
  type        = string
  default     = "mastodon"
  description = "DO managed PostgreSQL cluster database name"
}

variable "pg_cluster_db_user" {
  type        = string
  default     = "mastodon"
  description = "DO managed PostgreSQL cluster database user"
}

variable "pg_cluster_connection_pool_size" {
  type        = number
  default     = 20
  description = "PgBouncer connection pool size"
}

# =============== EXTERNAL REDIS CONFIG VARS (DO MANAGED) ================= #

variable "enable_external_redis" {
  type        = bool
  default     = false
  description = "Enable external Redis cluster (DO managed)"
}

variable "redis_cluster_name" {
  type        = string
  default     = "redis-mastodon"
  description = "DO managed Redis cluster name"
}

variable "redis_cluster_version" {
  type        = string
  default     = "7"
  description = "DO managed Redis engine version"
}

variable "redis_cluster_region" {
  type        = string
  default     = "nyc1"
  description = "DO managed Redis cluster region"
}

variable "redis_cluster_size" {
  type        = string
  default     = "db-s-1vcpu-1gb"
  description = "DO managed Redis cluster worker nodes size"
}

variable "redis_cluster_node_count" {
  type        = number
  default     = 1
  description = "DO managed Redis cluster node count"
}

# ====================== EXTERNAL ELASTICSEARCH CONFIG VARS ====================== #

variable "enable_external_elasticsearch" {
  type        = bool
  default     = false
  description = "Enable external Elasticsearch cluster (self managed)"
}

# ====================== EXTERNAL S3 CONFIG VARS (DO MANAGED) ==================== #

variable "enable_external_s3" {
  type        = bool
  default     = false
  description = "Enable external S3 for Mastodon persistent data (DO Spaces)"
}

variable "s3_bucket_name" {
  type        = string
  default     = "mastodon-st"
  description = "Mastodon DO Spaces S3 bucket name (must be unique)"
}

variable "s3_bucket_region" {
  type        = string
  default     = "nyc3"
  description = "Mastodon DO Spaces S3 bucket region"
}
