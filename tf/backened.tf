terraform {

  backend "remote" {
    organization = "mk_org"
    hostname = "app.terraform.io"
    workspaces {
      name = "n8n-deployment"
    }
  }

    required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.51.0"  
    }
  }

}