resource "google_storage_bucket" "tf_state_bucket" {
  name          = "devops-blog-tf-state-rutuja"
  location      = "US"
  force_destroy = true # lets Terraform delete bucket if needed

  uniform_bucket_level_access = true # controls IAM level access bound to only bucket level.

  versioning {
    enabled = true # safe for rollback
  }
}
