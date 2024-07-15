#!/usr/bin/env bash

set -eux

kind delete cluster --name "${1}" || true
