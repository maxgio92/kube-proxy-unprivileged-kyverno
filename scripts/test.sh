#!/usr/bin/env bash

echo
echo "*** Running test suite ***"
echo

kubectl apply -f ./pod-privileged-init-only.yaml || { echo "*** Should allow kube-proxy privileged init-container: FAIL"; exit 1; }
echo "*** Should allow kube-proxy privileged init-container: PASS"
kubectl apply -f ./pod-privileged-main.yaml && { echo "*** Should disallow kube-proxy privileged main container: FAIL"; exit 1; }
echo "*** Should disallow kube-proxy privileged main container: PASS"

