.PHONY: validate init build

init:
	packer init template/$(AMI_TYPE)/
validate:
	packer validate template/$(AMI_TYPE)/
build:
	packer build \
	-var "ami_prefix=$(AMI_NAME)" \
	-var "ami_type=$(AMI_TYPE)" \
	-var "ami_account_id=$(AWS_ACCOUNT_ID)" \
	template/$(AMI_TYPE)/ \
	




