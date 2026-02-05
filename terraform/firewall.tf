resource "google_compute_firewall" "devops_firewall" {
  name    = "devops-blog-firewall"
  network = "default"  # default VPC network

  target_tags = ["devops-blog"] # VM network_tags

  # Allow incoming traffic
  allow {
    protocol = "tcp"
    ports    = ["22", "5000", "8080", "30000-32767"]
  }

  direction    = "INGRESS"
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from any IP address.
  priority      = 1000
}
