## Kube-proxy unprivileged Kyverno ClusterPolicies

From Kubernetes [1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md#feature-5), the `Kube-proxy` can run unprivileged thanks to the option to run privileged for configs only, during init.

That option has been enabled by the following pull-request:
* [kube-proxy: Optionally do privileged configs only](https://github.com/kubernetes/kubernetes/pull/120864)

The following blog explains the enabled unprivileged `kube-proxy` configuration:
* [Kubernetes supports running kube-proxy in an unprivileged container](https://www.kubernetes.dev/blog/2024/01/05/kube-proxy-non-privileged/)

This repository provides two Kyverno `ClusterPolicy` examples to disallow all privileged containers, introducing an exception for the only `kube-proxy`'s init container.

It provides also an example of the `kube-proxy` `DaemonSet` unprivileged configuration.

### Pre-requisites

* Kyverno repository

```shell
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
```

### Run test

The test will:
1. spin up a `kind` cluster with Kyverno installed without *kube-system* `Namespace`'s resources exception.
1. Create the `ClusterPolicies` required to:
  * disallow all `Pod`s with privileged init containers, ephemeral containers, and containers, except *kube-proxy* `Pod`s selected by label
  * disallow *kube-proxy* `Pod`s selected by label `Pod`s with privileged ephemeral containers - it allows *kube-proxy* privileged init container

```shell
make test
```
