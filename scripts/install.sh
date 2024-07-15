#!/usr/bin/env bash

set -eux

kind create cluster --name "${1}" || true
kubectl apply -f ./kube-proxy.yaml
kubectl wait --for=condition=Available -n kube-system deployment/coredns --timeout=300s
helm upgrade --install -n kyverno --create-namespace kyverno kyverno/kyverno -f ./kyverno/values-no-exclude-kube-system.yaml
kubectl wait --for=condition=Available -n kyverno deployment/kyverno-admission-controller --timeout=300s
kubectl wait --for=condition=Available -n kyverno deployment/kyverno-background-controller --timeout=300s
kubectl wait --for=condition=Available -n kyverno deployment/kyverno-cleanup-controller --timeout=300s
kubectl wait --for=condition=Available -n kyverno deployment/kyverno-reports-controller --timeout=300s
kubectl apply -f ./cluster-policies
kubectl wait --for=condition=Ready -n kyverno clusterpolicies.kyverno.io/disallow-privileged-containers --timeout=300s
kubectl wait --for=condition=Ready -n kyverno clusterpolicies.kyverno.io/disallow-privileged-containers-kube-proxy  --timeout=300s
kubectl config set-context --current --namespace kube-system
kubectl get clusterpolicies.kyverno.io
