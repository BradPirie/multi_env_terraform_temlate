## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##
## This file is maintained in the `terraform` ##
## repo, any changes *will* be overwritten!!  ##
## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##

# From StackOverflow: https://stackoverflow.com/a/20566812
UNAME:= $(shell uname)
ifeq ($(UNAME),Darwin)
		OS_X  := true
		SHELL := /bin/bash
else
		OS_DEB  := true
		SHELL := /bin/bash
endif

TERRAFORM:= $(shell command -v terraform 2> /dev/null)
TERRAFORM_VERSION:= "1.0.5"

ifeq ($(OS_X),true)
		TERRAFORM_MD5:= $(shell md5 -q `which terraform`)
		TERRAFORM_REQUIRED_MD5:= 0ad2b6d223142cde8e5f052aac1d12bb
else
		TERRAFORM_MD5:= $(shell md5sum - < `which terraform` | tr -d ' -')
		#TODO update
		TERRAFORM_REQUIRED_MD5:= e7388b9eb208ce2e98d21d25e4920330
endif

default:
	@echo "Creates a Terraform system from a template."
	@echo "The following commands are available:"
	@echo " - init-backend       : creates the S3 bucket in which we will store the Terraform state."
	@echo " - plan               : runs terraform plan for an environment"
	@echo " - apply              : runs terraform apply for an environment"
	@echo " - destroy            : will delete the entire project's infrastructure"
	@echo " - destroy-backend    : will delete the terraform S3 backend resources (i.e. the S3 bucket and dynamodb table"

check:
	@echo "Checking Terraform version... expecting md5 of [${TERRAFORM_REQUIRED_MD5}], found [${TERRAFORM_MD5}]"
	@if [ "${TERRAFORM_MD5}" != "${TERRAFORM_REQUIRED_MD5}" ]; then echo "Please ensure you are running terraform ${TERRAFORM_VERSION}."; exit 1; fi

init-backend: check
	$(call check_defined, ENV, Please set the ENV to plan for. Values should be dev, test, uat or prod)
	@terraform fmt

	@terraform init --backend-config "env_vars/$(value ENV)-terraform-backend.conf" $(value TF_OPTIONS)
	@echo "Running terraform apply --auto-approve"
	@terraform apply -target module.terraform_state_backend --auto-approve  -var-file="env_vars/$(value ENV).tfvars"   
	@echo "Running terraform init -force-copy to move state file to S3 backend"
	@terraform init -force-copy

plan: check
	$(call check_defined, ENV, Please set the ENV to plan for. Values should be dev, test, uat or prod)
	@terraform fmt

	@echo "Pulling the required modules..."
	@terraform get

	@echo 'Switching to the [$(value ENV)] environment ...'
	@terraform workspace select $(value ENV)

	@terraform plan  \
  	  -var-file="env_vars/$(value ENV).tfvars" \
		-out $(value ENV).plan


apply: check
	$(call check_defined, ENV, Please set the ENV to apply. Values should be dev, test, uat or prod)

	@echo 'Switching to the [$(value ENV)] environment ...'
	@terraform workspace select $(value ENV)

	@echo "Will be applying the following to [$(value ENV)] environment:"
	@terraform show -no-color $(value ENV).plan

	@terraform apply $(value ENV).plan
	@rm $(value ENV).plan


destroy: check
	@echo "Switching to the [$(value ENV)] environment ..."
	@terraform workspace select $(value ENV)

	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@echo "Are you really sure you want to completely destroy [$(value ENV)] environment ?"
	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@read -p "Press enter to continue"
	@terraform destroy \
		-var-file="env_vars/$(value ENV).tfvars"

destroy-backend: check
	@echo "Switching to the [$(value ENV)] environment ..."
	@terraform workspace select $(value ENV)

	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@echo "Are you really sure you want to completely destroy [$(value ENV)] back-end ?"
	@echo "NOTE: You need to set the force_destroy option in the <terraform_state_backend> before running this option!"
	@echo "## 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥 ##"
	@read -p "Press enter to continue"
	
	@terraform apply -target module.terraform_state_backend -auto-approve
	@terraform init -force-copy \
		-var-file="env_vars/$(value ENV).tfvars" \
	@terraform destroy \
		-var-file="env_vars/$(value ENV).tfvars"


# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))
