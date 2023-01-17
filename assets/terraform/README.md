# Mastodon Infrastructure Automation via Terraform

## Overview

Terraform is a very popular tool used for infra tasks automation, and it works very well for all major cloud providers. [DigitalOcean](https://www.digitalocean.com) is no exception.

The Terraform code provided in this repository is able to:

1. Provision a DOKS cluster to deploy the Bitnami Mastodon Helm chart via [doks.tf](./doks.tf).
2. Kubernetes specific configuration for Mastodon via [k8s-config.tf](./k8s-config.tf).
3. Install and configure a DO managed PostgreSQL cluster via [managed-postgres.tf](./managed-postgres.tf).
4. Install and configure a DO managed Redis cluster via [managed-redis.tf](./managed-redis.tf).
5. Install and configure a DO Spaces bucket via [s3.tf](./s3.tf).
6. Input variables and main module behavior is controlled via [variables.tf](./variables.tf).

The Terraform code can be used as a module in other projects as well, if desired.

All important aspects are configured via Terraform input variables. Some [sample .tfvars files](variants/) are provided to get you started quickly.

## Requirements

The only requirement is [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed on your machine, and at least some basic knowledge about the tool and main Terraform concepts. You also need your DigitalOcean access token at hand.

## Managing DOKS Configuration

Following input variables are available to configure DOKS (each variable purpose is explained in the `description` field):

```json
# ===================== DOKS CONFIG VARS =======================

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

variable "doks_default_node_pool" {
  type = map
  default = {
    name       = "mastodon-default"
    node_count = 2
    size       = "s-2vcpu-4gb"
  }
  description = "DOKS cluster default node pool configuration"
}

variable "doks_additional_node_pools" {
  type = map
  default = {}
  description = "DOKS cluster extra node pool configuration"
}
```

## Managing Kubernetes Configuration

Following input variables are available to configure Kubernetes stuff:

```json
# =============== K8S CONFIG VARS ==================

variable "mastodon_k8s_namespace" {
  type        = string
  default     = "mastodon"
  description = "Kubernetes namespace to use for the Mastodon Helm release"
}

variable "mastodon_web_domain" {
  type = string
  description = "Sets the domain name for your Mastodon instance (REQUIRED)"
}
```

## Managing External PostgreSLQ Configuration (DO Managed)

Following input variables are available to configure DO Managed PostgreSQL (each variable purpose is explained in the `description` field):

```json
# =============== EXTERNAL POSTGRES CONFIG VARS (DO MANAGED) =================

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
```

## Managing External Redis Configuration (DO Managed)

Following input variables are available to configure DO Managed Redis (each variable purpose is explained in the `description` field):

```json
# =============== EXTERNAL REDIS CONFIG VARS (DO MANAGED) =================

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
```

## Managing External S3 Configuration (DO Managed)

Following input variables are available to configure DO Spaces (each variable purpose is explained in the `description` field):

```json
# ====================== EXTERNAL S3 CONFIG VARS (DO MANAGED) ======================

variable "enable_external_s3" {
  type        = bool
  default     = false
  description = "Enable external S3 for Mastodon persistent data (DO Spaces)"
}

variable "s3_bucket_name" {
  type        = string
  default     = "mastodon-st"
  description = "Mastodon DO Spaces S3 bucket name"
}

variable "s3_bucket_region" {
  type        = string
  default     = "nyc3"
  description = "Mastodon DO Spaces S3 bucket region"
}

variable "s3_bucket_access_key_id" {
  type        = string
  sensitive   = true
  default = ""
  description = "Mastodon DO Spaces S3 bucket access key id"
}

variable "s3_bucket_access_key_secret" {
  type        = string
  sensitive   = true
  default = ""
  description = "Mastodon DO Spaces S3 bucket access key secret"
}
```
