resource "hcloud_server" "server_test" {
  name        = "{{ var.server_name }}"
  ssh_keys    = [data.hcloud_ssh_key.key.id]
  image       = "ubuntu-24.04"
  server_type = "cx22"
  datacenter = "fsn1-dc14"
  


    labels = {
        "created_by"  = "terraform"
    }
 
  public_net {
    ipv4_enabled = false
    ipv6_enabled = true
  }

    firewall_ids = [hcloud_firewall.custom.id]

    user_data = <<-EOF
        #cloud-config
        package_update: true
        package_upgrade: true

        groups:
        - docker

        packages:
        - apt-transport-https
        - ca-certificates
        - curl
        - gnupg-agent
        - software-properties-common

        runcmd:
        - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        - apt-get update -y
        - apt-get install -y docker-ce docker-ce-cli containerd.io
        - curl -L "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        - chmod +x /usr/local/bin/docker-compose
        - systemctl enable docker
        - systemctl enable containerd
        - systemctl start docker
        - systemctl start containerd
        - systemctl status docker
        - systemctl status containerd
        - docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n

        final_message: "Docker host should be up and running, this took me $UPTIME seconds"

EOF
}