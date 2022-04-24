terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

module "app" {
  source = "../../modules/app"
  
}

provider "scaleway" {
}


resource "scaleway_k8s_cluster" "cluster" {
  name    = "${module.app.name}-k8s"
  version = "1.23"
  cni     = "calico"
  auto_upgrade {
    enable = true
    maintenance_window_day = "monday"
    maintenance_window_start_hour = 5
  }
}

resource "scaleway_k8s_pool" "pool" {
  cluster_id = scaleway_k8s_cluster.cluster.id
  name       = "${module.app.name}-pool"
  node_type  = "DEV1-M"
  size       = 1
}
