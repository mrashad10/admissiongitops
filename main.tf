variable "do_token" {}
variable "ssh_fingerprint" {}
variable "ssh_priv" {}
variable "ssl_cert" {}
variable "ssl_key" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token  = var.do_token
}

resource "digitalocean_droplet" "swarm" {
  image = "ubuntu-20-04-x64"
  name = "swarm.mrashad.com"
  region = "lon1"
  size = "2gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    user        = "root"
    type        = "ssh"
    host        = self.ipv4_address
    private_key = file(var.ssh_priv)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = var.ssl_cert
    destination = "/etc/ssl/cert.pem"
  }

  provisioner "file" {
    source      = var.ssl_key
    destination = "/etc/ssl/privkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.name} ${self.ipv4_address}",
      # "apt-get clean; apt-get update; apt-get upgrade -y"
    ]
  }
}

resource "digitalocean_record" "A-swarm" {
  domain = "mrashad.com"
  type = "A"
  name = "swarm"
  value = digitalocean_droplet.swarm.ipv4_address
}

resource "digitalocean_droplet" "worker1" {
  image = "ubuntu-20-04-x64"
  name = "worker1.mrashad.com"
  region = "lon1"
  size = "2gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    user        = "root"
    type        = "ssh"
    host        = self.ipv4_address
    private_key = file(var.ssh_priv)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = var.ssl_cert
    destination = "/etc/ssl/cert.pem"
  }

  provisioner "file" {
    source      = var.ssl_key
    destination = "/etc/ssl/privkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.name} ${self.ipv4_address}",
      # "apt-get clean; apt-get update; apt-get upgrade -y"
    ]
  }
}

resource "digitalocean_record" "A-worker1" {
  domain = "mrashad.com"
  type = "A"
  name = "worker1"
  value = digitalocean_droplet.worker1.ipv4_address
}

resource "digitalocean_droplet" "worker2" {
  image = "ubuntu-20-04-x64"
  name = "worker2.mrashad.com"
  region = "lon1"
  size = "2gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    user        = "root"
    type        = "ssh"
    host        = self.ipv4_address
    private_key = file(var.ssh_priv)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = var.ssl_cert
    destination = "/etc/ssl/cert.pem"
  }

  provisioner "file" {
    source      = var.ssl_key
    destination = "/etc/ssl/privkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.name} ${self.ipv4_address}",
      # "apt-get clean; apt-get update; apt-get upgrade -y"
    ]
  }
}

resource "digitalocean_record" "A-worker2" {
  domain = "mrashad.com"
  type = "A"
  name = "worker2"
  value = digitalocean_droplet.worker2.ipv4_address
}

resource "digitalocean_droplet" "worker3" {
  image = "ubuntu-20-04-x64"
  name = "worker3.mrashad.com"
  region = "lon1"
  size = "2gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    user        = "root"
    type        = "ssh"
    host        = self.ipv4_address
    private_key = file(var.ssh_priv)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = var.ssl_cert
    destination = "/etc/ssl/cert.pem"
  }

  provisioner "file" {
    source      = var.ssl_key
    destination = "/etc/ssl/privkey.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.name} ${self.ipv4_address}",
      # "apt-get clean; apt-get update; apt-get upgrade -y"
    ]
  }
}

resource "digitalocean_record" "A-worker3" {
  domain = "mrashad.com"
  type = "A"
  name = "worker3"
  value = digitalocean_droplet.worker3.ipv4_address
}

output "result" {
  value = {
    swarm = digitalocean_droplet.swarm.ipv4_address
    worker1 = digitalocean_droplet.worker1.ipv4_address
    worker2 = digitalocean_droplet.worker2.ipv4_address
    worker3 = digitalocean_droplet.worker3.ipv4_address
  }
}
