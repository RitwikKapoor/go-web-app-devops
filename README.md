# Golang Static Website Deployment

This repository contains the source code and deployment configurations for a simple static website developed using Golang. The application is deployed on a DigitalOcean Kubernetes Cluster with Nginx Ingress as the load balancer. The infrastructure is managed using Terraform, and CI/CD processes are handled by GitHub Actions and ArgoCD.

## Project Overview

### Features

- **Static Website**: Developed using Golang.
- **Kubernetes Cluster**: Deployed on DigitalOcean using Terraform.
- **Nginx Ingress**: Configured as the load balancer.
- **CI Pipeline**: Automated testing, Docker image building, and Helm chart updates using GitHub Actions.
- **CD Pipeline**: Continuous Delivery and automated deployment using ArgoCD.

## Prerequisites

- Golang
- Docker
- DigitalOcean account
- kubectl
- Terraform
- Helm
- ArgoCD

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/RitwikKapoor/go-web-app-devops.git
cd go-web-app-devops
```

### 2. Create the Kubernetes Cluster

- Populate the terraform.tfvars file

```
do_token = "your_digitalocean_api_token"
k8s_config = {
  n_count = "desired_node_count"
  n_size  = "desired_node_size"
  region  = "desired_region"
}
```

- Run the following commands to create the k8s cluster on DigitalOcean

```bash
cd terraform
terraform init
terraform apply
```

### 3. Create the Nginx Ingress Load Balancer on DigitalOcean

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/do/deploy.yaml
```

### 4. Install ArgoCD

- Install Argo CD using manifests
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- Access the Argo CD UI (Loadbalancer service)
```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

- Get the Loadbalancer service IP
```bash
kubectl get svc argocd-server -n argocd
```

- Access the ArgoCD UI and set it up

### 5. Add the secret variables for the GitHub Actions in your repository

```
TOKEN: Your GitHub Personal Access Token.
DOCKERHUB_USERNAME: Your DockerHub username.
DOCKERHUB_TOKEN: Your DockerHub Access Token.
```