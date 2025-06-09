# n8n-deployment
n8n infrastructure



## Manual steps

  Next steps:
  1. Point your domain to this server's IP address
  2. Get SSL certificate: sudo certbot --nginx -d ${domain_name}  && sudo systemctl status n8n
  3. Access n8n at: https://${domain_name}
  4. Login with: ${admin_username} / [your password]

