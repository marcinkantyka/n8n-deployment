terraform { 
  cloud { 
    
    organization = "mk_org" 
    hostname = "app.terraform.io"
    
    workspaces { 
      name = "n8n-deployment" 
    } 
  } 
}