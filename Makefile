.PHONY: validate init build

init:
	packer init templates/$(AMI_TYPE)/
validate:
	packer validate templates/$(AMI_TYPE)/
build:
	packer build \
	-var "ami_prefix=$(AMI_NAME)" \
	-var "ami_type=$(AMI_TYPE)" \
	-var "ami_account_id=$(AWS_ACCOUNT_ID)" \
	templates/$(AMI_TYPE)/ \
	




