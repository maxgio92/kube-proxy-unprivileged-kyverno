CLUSTER_NAME ?= kube-proxy-unprivileged-kyverno

.PHONY: test
test:
	@$(MAKE) install
	@$(MAKE) run-test-suite
	@$(MAKE) cleanup

.PHONY: install
install:
	@./scripts/install.sh $(CLUSTER_NAME)

.PHONY: run-test-suite
run-test-suite:
	@./scripts/test.sh

.PHONY: cleanup
cleanup:
	@./scripts/cleanup.sh $(CLUSTER_NAME)
