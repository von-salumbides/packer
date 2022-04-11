variable "runtime" {
  type    = string
  default = "centos"
}

source "docker" "image" {
  image       = "amazonlinux"
  commit = true
}

build {
    sources = [
        "source.docker.image"
    ]
    provisioner "shell" {
        script       = "template/Docker-Image/ansible.sh"
        pause_before = "10s"
        timeout      = "10s"
    }
    provisioner "ansible-local" {
        playbook_file   = "template/Docker-Image/playbook.yml"
    # extra_arguments = [
    #     "--extra-vars", "\"pizza_toppings=${var.topping}\""
    #     ]
    }
}