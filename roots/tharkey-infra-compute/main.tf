terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    dns = {
      source = "hashicorp/dns"
    }
  }
  required_version = ">= 0.13"
}

module "app" {
  source = "../../modules/app"
}


provider "kubernetes" {
  config_path = "../../kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "../../kubeconfig"
  }
}

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

data "dns_a_record_set" "app" {
  host = module.app.subdomain
}

locals {
  ip = "${join(",", data.dns_a_record_set.app.addrs)}"
}

resource "helm_release" "ingress-nginx" {
  name  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = kubernetes_namespace.ingress-nginx.id

  set {
    name = "controller.service.loadBalancerIP"
    value = local.ip
  }
}

