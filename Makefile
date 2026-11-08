KUBECTL ?= kubectl

INFRA_PATH := infrastructure/overlays/production
R2D2_PATH := apps/r2d2/overlays/production

.DEFAULT_GOAL := help

.PHONY: help validate-infra diff-infra deploy-infra status top validate-r2d2 diff-r2d2 deploy-r2d2 status-r2d2

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

validate-r2d2:
	$(KUBECTL) kustomize $(R2D2_PATH)

diff-r2d2:
	$(KUBECTL) diff -n r2d2 -k $(R2D2_PATH)

deploy-r2d2:
	$(KUBECTL) apply -k $(R2D2_PATH)
	$(KUBECTL) rollout status deployment/r2d2-api -n r2d2 --timeout=180s

status-r2d2:
	$(KUBECTL) get pods,deployments,services -n r2d2