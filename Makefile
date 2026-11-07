KUBECTL ?= kubectl

INFRA_PATH := infrastructure/overlays/production

.PHONY: help validate-infra diff-infra deploy-infra status top

help:
	@echo "Available commands:"
	@echo "  make validate-infra"
	@echo "  make diff-infra"
	@echo "  make deploy-infra"
	@echo "  make status"
	@echo "  make top"

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