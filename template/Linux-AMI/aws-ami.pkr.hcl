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

source "amazon-ebs" "linux" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "aws-packer"
  sources = [
    "source.amazon-ebs.linux"
  ]
  provisioner "shell" {
        script       = "template/${var.ami_type}/ansible.sh"
        pause_before = "10s"
        timeout      = "10s"
    }
  provisioner "ansible-local" {
    playbook_file   = "template/${var.ami_type}/playbook.yml"
    # extra_arguments = [
    #     "--extra-vars", "\"php_version=${var.php_version}\""
    # ]
  }
}
