.DEFAULT_GOAL := test
ENVIRONMENT ?= dev

readme:
	readme-generator-for-helm -v values.yaml -r README.md

test:
	helm install --dry-run mongo .

test-dev:
	helm install --dry-run mongo --values ../../blockapt/values/${ENVIRONMENT}/mongodb.yaml .
