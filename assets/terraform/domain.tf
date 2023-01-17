resource "digitalocean_domain" "mastodon" {
  name       = var.mastodon_web_domain
}

resource "digitalocean_certificate" "mastodon" {
  name    = "le-mastodon"
  type    = "lets_encrypt"
  domains = [digitalocean_domain.mastodon.id]
}
