variable "project_id" {
  description = "GCP Project ID"
  default     = "devops-blog-486510"
}

variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "Name of the VM"
  default     = "devops-blog-vm"
}

variable "machine_type" {
  description = "VM machine type"
  default     = "e2-micro"
}

variable "network_tags" {
  description = "Network tags for firewall rules"
  type        = list(string)
  default     = ["devops-blog"]
}
