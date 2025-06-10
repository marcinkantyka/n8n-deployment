# n8n-deployment

<!-- Badges -->
![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue?logo=terraform)
![Terraform Cloud](https://img.shields.io/badge/Terraform%20Cloud-Enabled-623CE4?logo=terraform)
![Last Commit](https://img.shields.io/github/last-commit/marcinkantyka/n8n-deployment)
![Issues](https://img.shields.io/github/issues/marcinkantyka/n8n-deployment)
![Pull Requests](https://img.shields.io/github/issues-pr/marcinkantyka/n8n-deployment)

This repository provides an automated, production-ready deployment of [n8n](https://n8n.io/) using Terraform and cloud-init on a Hetzner Cloud Ubuntu server. It provisions the infrastructure, configures security, and sets up n8n with HTTPS and basic authentication.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Definitions](#definitions)
- [Deployment Steps](#deployment-steps)
- [Manual Post-Deployment Steps](#manual-post-deployment-steps)
- [Accessing n8n](#accessing-n8n)
- [Security Notes](#security-notes)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Project Overview

This project automates the deployment of n8n, an open-source workflow automation tool, on a dedicated Ubuntu server. It uses:

- **Terraform** for infrastructure provisioning (Hetzner Cloud VM, firewall, SSH keys)
- **cloud-init** for server configuration (Node.js, n8n, Nginx, SSL, UFW, fail2ban)
- **Nginx** as a reverse proxy with HTTPS
- **Basic authentication** for n8n access

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed locally
- Hetzner Cloud account and API token
- Registered domain name (pointed to the server after deployment)
- SSH key pair for server access
- Basic knowledge of Terraform and Linux administration

> **Important:**  
> To enable GitHub Actions to authenticate with Terraform Cloud, you must add your Terraform Cloud API token as a repository secret named `TF_API_TOKEN`.  
>  
> - Go to your GitHub repository → Settings → Secrets and variables → Actions → New repository secret  
> - Name: `TF_API_TOKEN`  
> - Value: *your Terraform Cloud API token*  
>  
> This is required for the remote backend configuration in `backened.tf` to work.
---

## Definitions

- **n8n**: Open-source workflow automation tool.
- **Terraform**: Infrastructure as Code (IaC) tool for provisioning cloud resources.
- **cloud-init**: Tool for early initialization of cloud instances.
- **Hetzner Cloud**: Cloud provider used for hosting the VM.
- **UFW**: Uncomplicated Firewall for Linux.
- **fail2ban**: Intrusion prevention software framework.

---

## Deployment Steps

1. **Clone the repository**
   ```sh
   git clone https://github.com/your-org/n8n-deployment.git
   cd n8n-deployment/tf
   ```

2. **Configure Terraform variables**

   Edit `.auto.tfvars` to set:
   - `domain_name` (your FQDN, e.g., `n8n.example.com`)
   - `admin_username` and `admin_password` (for n8n basic auth)
   - `ssh_key_name` (your Hetzner Cloud SSH key)
   - `firewall_rules` (adjust allowed IPs/ports as needed)

3. **Initialize and apply Terraform**
   ```sh
   terraform init
   terraform apply
   ```
   Confirm the plan and wait for provisioning to complete.

---

## Manual Post-Deployment Steps

1. **Point your domain to the server's public IP**
   - Update your DNS A record for `${domain_name}` to the server's IP.

2. **Obtain a valid SSL certificate**
   - SSH into the server:
     ```sh
     ssh root@<server-ip>
     ```
   - Run Certbot to obtain and install a certificate:
     ```sh
     sudo certbot --nginx -d ${domain_name}
     sudo systemctl reload nginx
     ```

3. **Verify n8n service**
   ```sh
   sudo systemctl status n8n
   ```

---

## Accessing n8n

- Open your browser and navigate to:  
  `https://${domain_name}`
- Login with:
  - **Username:** `${admin_username}`
  - **Password:** `${admin_password}`

---

## Security Notes

- Only whitelisted IPs (see `firewall_rules` in `.auto.tfvars`) can access SSH, HTTPS, and n8n ports.
- UFW and fail2ban are enabled for additional protection.
- Change the default admin password after first login.
- Keep your system and n8n updated.

---

## Customization

- **n8n configuration:** Edit `/home/n8n/.env` on the server for advanced settings.
- **Nginx configuration:** See `/etc/nginx/sites-available/n8n`.
- **Firewall rules:** Adjust in `.auto.tfvars` and re-apply Terraform.

---

## Troubleshooting

- **n8n not running?**
  ```sh
  sudo systemctl status n8n
  sudo journalctl -u n8n
  ```
- **Nginx issues?**
  ```sh
  sudo nginx -t
  sudo systemctl status nginx
  ```
- **SSL certificate issues?**
  - Ensure DNS is propagated and domain points to server IP before running Certbot.

---

## License

This project is licensed under the MIT License.

---

