SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
## help| Makefile| Prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s '|' |  sed -e 's/^/ /'

.PHONY: lint
## lint| Terraform| Validate configuration files and run linter
lint:
	terraform validate
	tflint

.PHONY: fmt format
## fmt,format| Terraform| Rewrite configuration files to a canonical format
fmt format:
	terraform fmt -recursive .

.PHONY: init
## init| Terraform| Initialize
init:
	terraform init --upgrade
	tflint --init

.PHONY: plan
## plan| Terraform| Plan
plan:
	terraform plan

.PHONY: apply
## apply| Terraform| Apply
apply:
	terraform apply

.PHONY: refresh
## refresh| Terraform| Refresh
refresh:
	terraform refresh

.PHONY: list
## list| Terraform| List resources in the state
list:
	terraform state list

.PHONY: state
## state| Terraform| Pull state (JSON)
state:
	terraform state pull | jq

.PHONY: out
## out| Terraform| Outputs
out:
	terraform output
