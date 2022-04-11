packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ubuntu-aws-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "packer-ubuntu-aws-${local.timestamp}"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
        script       = "${path.root}/scripts/ansible.sh"
        pause_before = "10s"
        timeout      = "10s"
    }
  provisioner "ansible-local" {
    playbook_file   = "${path.root}/playbook/playbook.yml"
    playbook_dir = "${path.root}/playbook"
  }
}