terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "my_k8s" {
  name   = "my-k8s"
  region = var.k8s_config.region
  version = "1.30.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = var.k8s_config.n_size
    node_count = var.k8s_config.n_count
  }
}

resource "local_file" "kubeconfig" {
  content  = digitalocean_kubernetes_cluster.my_k8s.kube_config[0].raw_config
  filename = "kubeconfig.yaml"
}

