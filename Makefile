KUBECTL ?= kubectl

INFRA_PATH := infrastructure/overlays/production
.DEFAULT_GOAL := help

.PHONY: help validate-infra diff-infra deploy-infra status top

help:
	@printf '%s\n' \
		'Usage: make <command>' \
		'' \
		'Infrastructure:' \
		'  validate-infra  Render production Kustomize manifests to validate them.' \
		'  diff-infra      Compare production manifests with the live cluster.' \
		'  deploy-infra    Apply production manifests to the live cluster.' \
		'' \
		'Cluster status:' \
		'  status          List pods in all namespaces.' \
		'  top             Show pod resource usage in all namespaces.' \
		'' \
		'Run make help to show this list. GNU Make reserves --help for its own options.'

validate-infra:
	$(KUBECTL) kustomize $(INFRA_PATH)

diff-infra:
	$(KUBECTL) diff -k $(INFRA_PATH)

deploy-infra:
	$(KUBECTL) apply -k $(INFRA_PATH)

status:
	$(KUBECTL) get pods -A

top:
	$(KUBECTL) top pods -A