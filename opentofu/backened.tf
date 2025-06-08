terraform {
  backend "remote" {
    organization = "mk_org"
    workspaces {
      name = "n8n-deployment"
    }
  }
}