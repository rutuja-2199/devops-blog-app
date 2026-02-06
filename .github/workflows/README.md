# GitHub Actions Workflows

This directory contains CI/CD workflows for automating Docker builds and Kubernetes deployments.

---

## Workflows Overview

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| **Docker Build & Push** | `docker-build.yml` | Push to `main` (`app/**`, `Dockerfile`) | Build and push Docker image to Docker Hub |
| **K3s Deployment** | `k8s.yaml` | Push to `main` (`k8s/**`) | Deploy to K3s cluster on GCP VM |

---

## 1. Docker Build & Push Workflow

**File:** `docker-build.yml`

### Trigger
- Push to `main` branch
- Only when changes to:
  - `app/**` (Flask application code)
  - `Dockerfile`

### Steps
1. **Checkout repository** - Pull latest code
2. **Login to Docker Hub** - Authenticate using secrets
3. **Build Docker Image** - Build from Dockerfile
4. **Push to Docker Hub** - Push to `rutujacvbuddy/flask-app:latest`

### Secrets Required
| Secret | Description |
|--------|-------------|
| `DOCKER_HUB_USERNAME` | Docker Hub username |
| `DOCKER_HUB_ACCESS_TOKEN` | Docker Hub access token (write permission) |

### Docker Hub Repository
`rutujacvbuddy/flask-app:latest`

---

## 2. K3s Deployment Workflow

**File:** `k8s.yaml`

### Trigger
- Push to `main` branch
- Only when changes to:
  - `k8s/**` (Kubernetes manifests)

### Steps
1. **Checkout repository** - Pull latest code
2. **Setup SSH key** - Configure SSH for VM access
3. **Apply K8s manifests** - Deploy to K3s cluster via SSH
   - Applies `deployment.yaml` from GitHub raw URL
   - Applies `service.yaml` from GitHub raw URL

### Secrets Required
| Secret | Description |
|--------|-------------|
| `VM_IP` | Public IP of GCP VM running K3s |
| `VM_USER` | SSH username (e.g., `rutuja`) |
| `VM_SSH_KEY` | Private SSH key for authentication |

### Deployment Target
- **Cluster:** K3s on GCP VM
- **Manifests:** Applied directly from GitHub (no cloning on VM)
- **Service:** NodePort `30007` for external access

---

## Complete CI/CD Flow

```
┌─────────────────────────────────────────────────────────────────┐
│  Developer pushes code to GitHub (main branch)                  │
└──────────────────────┬──────────────────────────────────────────┘
                       │
       ┌───────────────┴────────────────┐
       │                                │
       ▼                                ▼
┌──────────────┐              ┌──────────────────┐
│ app/** or    │              │ k8s/** changed?  │
│ Dockerfile   │              │                  │
│ changed?     │              └──────────┬───────┘
└──────┬───────┘                         │
       │                                 │
       ▼                                 ▼
┌──────────────────┐          ┌─────────────────────┐
│ Workflow:        │          │ Workflow:           │
│ docker-build.yml │          │ k8s.yaml            │
└──────┬───────────┘          └─────────┬───────────┘
       │                                 │
       ▼                                 ▼
┌──────────────────┐          ┌─────────────────────┐
│ 1. Build image   │          │ 1. SSH to VM        │
│ 2. Push to       │          │ 2. Apply manifests  │
│    Docker Hub    │          │    via kubectl      │
└──────────────────┘          └─────────┬───────────┘
                                        │
                                        ▼
                              ┌─────────────────────┐
                              │ K3s pulls new image │
                              │ from Docker Hub     │
                              │ and updates pods    │
                              └─────────────────────┘
```

---
