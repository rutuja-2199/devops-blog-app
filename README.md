# DevOps Blog App

A complete DevOps project demonstrating Flask web application deployment with Docker, Kubernetes (K3s), Terraform, and GitHub Actions CI/CD.

---

## Complete DevOps Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        DEVELOPMENT                                          │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Developer writes code                                               │   │
│  │  - Flask app (app/app.py)                                            │   │
│  │  - HTML templates (app/templates/)                                   │   │
│  │  - CSS styling (app/static/)                                         │   │
│  │  - Kubernetes manifests (k8s/)                                       │   │
│  └──────────────────────────────┬───────────────────────────────────────┘   │
└─────────────────────────────────┼───────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                     VERSION CONTROL (GitHub)                                │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  git push origin main                                                │   │
│  │  - Triggers GitHub Actions workflows                                 │   │
│  └──────────────────────────────┬───────────────────────────────────────┘   │
└─────────────────────────────────┼───────────────────────────────────────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    │                           │
                    ▼                           ▼
┌───────────────────────────────┐   ┌──────────────────────────────┐
│  CI/CD - Docker Build         │   │  CI/CD - K8s Deploy          │
│  (Trigger: app/**, Dockerfile)│   │  (Trigger: k8s/**)           │
│  ┌─────────────────────────┐  │   │  ┌────────────────────────┐  │
│  │ 1. Checkout code        │  │   │  │ 1. Checkout code       │  │
│  │ 2. Login to Docker Hub  │  │   │  │ 2. Setup SSH key       │  │
│  │ 3. Build Docker image   │  │   │  │ 3. SSH to GCP VM       │  │
│  │ 4. Push to Docker Hub   │  │   │  │ 4. Apply manifests     │  │
│  │    rutujacvbuddy/       │  │   │  │    via kubectl         │  │
│  │    flask-app:latest     │  │   │  └────────────────────────┘  │
│  └────────────┬────────────┘  │   └──────────────┬───────────────┘
└───────────────┼───────────────┘                  │
                │                                  │
                └──────────────┬───────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                     INFRASTRUCTURE (GCP)                                    │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Provisioned by Terraform                                            │   │
│  │  ┌──────────────────┐  ┌──────────────────┐  ┌─────────────────┐    │   │
│  │  │ Compute Engine   │  │ Firewall Rules   │  │ Cloud Storage   │    │   │
│  │  │ - VM (e2-micro)  │  │ - SSH (22)       │  │ - Terraform     │    │   │
│  │  │ - K3s installed  │  │ - HTTP (80)      │  │   state bucket  │    │   │
│  │  │ - Public IP      │  │ - Flask (5000)   │  │                 │    │   │
│  │  │                  │  │ - NodePort       │  │                 │    │   │
│  │  │                  │  │   (30000-32767)  │  │                 │    │   │
│  │  └──────────────────┘  └──────────────────┘  └─────────────────┘    │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────┬───────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                   KUBERNETES (K3s on GCP VM)                                │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Deployment: devops-blog-deployment                                  │   │
│  │  ┌──────────────────────────────┐                                    │   │
│  │  │         Pod                  │                                    │   │
│  │  │      flask-app:latest        │                                    │   │
│  │  │       Port: 5000             │                                    │   │
│  │  └──────────────┬───────────────┘                                    │   │
│  │                 │                                                     │   │
│  │                 ▼                                                     │   │
│  │  ┌──────────────────────────────────────────────────────────┐        │   │
│  │  │  Service: devops-blog-service (NodePort)                 │        │   │
│  │  │  - Internal Port: 5000                                   │        │   │
│  │  │  - External NodePort: 30007                              │        │   │
│  │  └──────────────────────────────────────────────────────────┘        │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────┬───────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          END USERS                                          │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Browser → http://<VM_PUBLIC_IP>:30007                               │   │
│  │  - Access Flask blog application                                     │   │
│  │  - View blog posts styled with Bootstrap                             │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Repository Structure

```
devops-blog-app/
├── app/
│   ├── app.py                    # Flask application (main server)
│   ├── README.md                 # App documentation & flow diagrams
│   ├── templates/
│   │   └── index.html            # HTML template (Jinja2)
│   └── static/
│       └── style.css             # Custom CSS styling
│
├── terraform/
│   ├── vm.tf                      # GCP Compute Engine VM
│   ├── firewall.tf                # Network firewall rules
│   ├── storage.tf                 # GCS bucket for state
│   ├── variables.tf               # Input variables
│   ├── outputs.tf                 # Output values (VM IP, etc.)
│   ├── versions.tf                # Provider versions
│   ├── backend.tf                 # Remote state config
│   ├── terraform.tfvars           # Variable values
│   └── README.md                  # Terraform setup guide
│
├── k8s/
│   ├── deployment.yaml            # K8s deployment (1 replica)
│   └── service.yaml               # NodePort service (30007)
│
├── .github/
│   └── workflows/
│       ├── docker-build.yml       # Build & push Docker image
│       ├── k8s.yaml               # Deploy to K3s cluster
│       └── README.md              # Workflows documentation
│
├── Dockerfile                     # Docker image configuration
├── requirements.txt               # Python dependencies
└── README.md                      # This file
```

---

## Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Application** | Flask 2.3.3 | Python web framework |
| **Frontend** | Bootstrap 5, Jinja2 | Responsive UI & templating |
| **Containerization** | Docker | Package app with dependencies |
| **Orchestration** | Kubernetes (K3s) | Container management & scaling |
| **Infrastructure** | Terraform + GCP | Infrastructure as Code |
| **CI/CD** | GitHub Actions | Automated build & deployment |
| **Registry** | Docker Hub | Container image storage |
| **Cloud Provider** | Google Cloud Platform | Compute, Storage, Networking |

---

## Key Features

**Infrastructure as Code** - Terraform manages GCP resources  
**Containerization** - Docker for consistent environments  
**Orchestration** - K3s (lightweight Kubernetes)  
**CI/CD Pipeline** - Automated builds and deployments  
**External Access** - NodePort service (30007)  
**Remote State** - Terraform state in GCS bucket  
**Security** - Firewall rules, SSH key authentication  

---

## Documentation

| Component | Documentation |
|-----------|---------------|
| **Flask App** | [app/README.md](app/README.md) |
| **Terraform** | [terraform/README.md](terraform/README.md) |
| **CI/CD Workflows** | [.github/workflows/README.md](.github/workflows/README.md) |

---

## Architecture Summary

```
GitHub → GitHub Actions → Docker Hub → K3s (GCP VM) → Users
   │           │              │            │
   │           │              │            └─ NodePort 30007
   │           │              └─ Container Registry
   │           └─ CI/CD Automation
   └─ Source Code
```

**Infrastructure:** Terraform provisions GCP VM with firewall rules  
**Application:** Flask web app with Bootstrap UI  
**Deployment:** K3s pulls Docker image, runs single pod  
**Access:** Public IP + NodePort 30007