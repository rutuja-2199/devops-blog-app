terraform {
  backend "gcs" {
    bucket  = "devops-blog-tf-state-rutuja"
    prefix  = "terraform/state"
  }
}
