terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    gandi = {
      source  = "go-gandi/gandi"
    }
  }
  required_version = ">= 0.13"
}

module "app" {
  source = "../../modules/app"
}

provider "scaleway" {
}

provider "gandi" {
}

data "gandi_domain" "domain" {
  name = "${module.app.domain}"
}

resource "scaleway_lb_ip" "ip" {
  
}

resource "scaleway_object_bucket" "static" {
  name = "${module.app.bucket}"
}

resource "gandi_livedns_record" "app" {
  zone = "${data.gandi_domain.domain.id}"
  name = "${module.app.phase}"
  type = "A"
  ttl = 3600
  values = [
    scaleway_lb_ip.ip.ip_address
  ]
}

resource "scaleway_registry_namespace" "registry" {
  name        = "${module.app.app_name}"
  is_public   = true
}