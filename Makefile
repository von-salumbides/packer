.PHONY: init build

init:
	packer init template/$(AMI_TYPE)/

build:
	packer build \
	-var "ami_prefix=$(AMI_NAME)" \
	-var "ami_type=$(AMI_TYPE)" \
	template/$(AMI_TYPE)/ \
	
validate:
	packer validate template/$(AMI_TYPE)/
init:
	packer init template/$(AMI_TYPE)/


