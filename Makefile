.PHONY: validate init build
fmt:
	packer fmt templates/$(AMI_TYPE)/
init: fmt
	packer init templates/$(AMI_TYPE)/
validate: fmt
	packer validate templates/$(AMI_TYPE)/
build: fmt
	packer build \
	-var "ami_prefix=$(AMI_NAME)" \
	-var "ami_type=$(AMI_TYPE)" \
	-var "ami_account_id=$(AWS_ACCOUNT_ID)" \
	templates/$(AMI_TYPE)/
buildv2:
	packer build \
	templates/Ubuntu-AMI
	




