variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "k8s_config" {
  type = object({
    n_count = number
    n_size  = string
    region  = string
  })
}