.PHONY: build

build:
	packer build template/$(AMI_TYPE)/ \
	-var "ami_prefix=$(AMI_NAME)" \
	-var "ami_type=$(AMI_TYPE)"
	
validate:
	packer validate template/$(AMI_TYPE)/
init:
	packer init template/$(AMI_TYPE)/


