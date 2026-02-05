## Terraform GCP Project: devops-blog

This Terraform project automates the creation of a basic VM, firewall, and remote state storage in Google Cloud Platform (GCP).

---

## Diagram (High Level)

```
Internet
   │
   ▼
Firewall Rules (ingress)
   ├─ SSH (22)
   ├─ App (5000, 8080)
   └─ Node Ports (30000-32767)
   │
   ▼
VM (Compute Engine)
   ├─ Ubuntu 22.04 LTS
   ├─ e2-micro
   └─ Tags for firewall targeting

Terraform State
   └─ GCS Bucket (versioning enabled)
```

---

## Project Overview

### VM (Compute Engine)
- Creates a virtual machine in GCP.
- Uses e2-micro (free tier eligible) with Ubuntu 22.04 LTS image.
- Network interface:
  - Connected to default VPC (internal network).
  - `access_config {}` provides a public IP to allow external access (SSH, curl, etc.).
  - Tags are used to associate VM with firewall rules.

### Firewall (Compute Engine)
- Allows traffic to VM from outside (ingress rules).
- Configured to open:
  - SSH (22)
  - Web / app ports (5000, 8080)
  - Kubernetes node ports (30000-32767)
- `source_ranges = ["0.0.0.0/0"]` allows traffic from anywhere (external internet).
- `target_tags` ensures firewall applies only to our VM.

### Remote State Storage (Cloud Storage / GCS)
- Terraform stores its state file in a GCS bucket instead of locally.
- Versioning enabled for rollback.
- `uniform_bucket_level_access = true` ensures IAM permissions are applied at bucket level.

---

## Variables & Versioning
- [variables.tf](variables.tf) contains configurable values like VM name, machine type, zone, network tags.
- [versions.tf](versions.tf) defines required Terraform and provider versions.

---

## Outputs
- [outputs.tf](outputs.tf) shows public IP of the VM after creation.

---

## Terraform Files Overview

| File | Purpose |
|------|---------|
| [vm.tf](vm.tf) | Defines VM resource and boot disk |
| [firewall.tf](firewall.tf) | Defines firewall rules for the VM |
| [storage.tf](storage.tf) | Creates GCS bucket for storing Terraform state |
| [variables.tf](variables.tf) | Defines configurable variables |
| [outputs.tf](outputs.tf) | Defines outputs such as VM public IP |
| [versions.tf](versions.tf) | Sets Terraform and provider version constraints |
| .terraform.lock.hcl | Locks provider versions for consistency |

Do not push: terraform.tfstate, terraform.tfstate.backup, .terraform/ folder (contains local state and plugins).
Safe to push: all .tf files and .terraform.lock.hcl.

---

## Usage / Commands

### Initialize Terraform

```bash
terraform init
```

Downloads providers and configures backend (GCS bucket for remote state).

### Check Execution Plan

```bash
terraform plan
```

Shows what Terraform will create, modify, or destroy.

### Apply Changes

```bash
terraform apply
```

Creates resources in GCP.

### Destroy Resources

```bash
terraform destroy
```

Deletes all resources created by Terraform.

---

## Rollback (Optional)

GCS versioning allows rolling back state to a previous version:

```bash
gsutil cp gs://<bucket>/terraform/state/default.tfstate#<generation> \
        gs://<bucket>/terraform/state/default.tfstate
terraform apply
```
