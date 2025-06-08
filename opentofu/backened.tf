terraform {
  backend "remote" {
    organization = "mk_org"
    workspaces {
      name = "n8n-deployment"
    }
  }

    required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.6.1"  
    }
  }

}