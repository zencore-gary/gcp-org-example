.DEFAULT_GOAL := test
ENVIRONMENT ?= dev

readme:
	readme-generator-for-helm -v values.yaml -r README.md

test:
	helm install --dry-run blockapt .

test-graphs:
	helm install --dry-run graphs --values ../../blockapt/values/${ENVIRONMENT}/graphs.yaml .

test-master:
	helm install --dry-run master --values ../../blockapt/values/${ENVIRONMENT}/master.yaml .

test-logger:
	helm install --dry-run logger --values ../../blockapt/values/${ENVIRONMENT}/logger.yaml .

test-mte:
	helm install --dry-run master --values ../../blockapt/values/${ENVIRONMENT}/mte.yaml .

test-pdf:
	helm install --dry-run master --values ../../blockapt/values/${ENVIRONMENT}/pdf.yaml .

test-search-logger:
	helm install --dry-run search-logger --values ../../blockapt/values/${ENVIRONMENT}/search-logger.yaml .

test-socket:
	helm install --dry-run socket --values ../../blockapt/values/${ENVIRONMENT}/socket.yaml .
