# CGI Space Helm Charts

| Name | Source | Notes |
| ---- | ------ | ----- |
| `bazel-cache` | CGI | <ul><li>Docker image used from `buchgr/bazel-remote`</li></ul> |
| `cert-manager` | [official](https://github.com/kubernetes/charts/tree/master/stable/cert-manager) | unchanged |
| `dex` | Mintel [dex-k8s-authenticator](https://github.com/mintel/dex-k8s-authenticator/tree/master/charts) | unchanged |
| `dex-k8s-authenticator` | Mintel [dex-k8s-authenticator](https://github.com/mintel/dex-k8s-authenticator/tree/master/charts) | unchanged |
| `elastic-stack` | [incubator](https://github.com/helm/charts/tree/master/incubator/elastic-stack) | unchanged |
| `elasticsearch` | [incubator](https://github.com/helm/charts/tree/master/incubator/elasticsearch) | unchanged |
| `fluentd-elasticsearch` | [official](https://github.com/helm/charts/tree/master/stable/fluentd-elasticsearch) | unchanged |
| `gerrit` | CGI | |
| `jenkins` | [official](https://github.com/kubernetes/charts/tree/master/stable/jenkins) | unchanged |
| `kube-prometheus` | CoreOS [prometheus-operator](https://github.com/coreos/prometheus-operator/tree/master/helm) | <ul><li>shuffled requirements into `./charts` dependencies</li><li>omitted `exporter-coredns` optional dep</li></ul> |
| `kubernetes-dashboard` | [official](https://github.com/kubernetes/charts/tree/master/stable/kubernetes-dashboard) | unchanged |
| `log-stack` | CGI | <ul><li>Collection of fluentd-elasticsearch, elasticsearch and kibana charts</li></ul> |
| `nexus` | CGI | <ul><li>Docker image provided: extends official image with GitHub auth plugin</li></ul> |
| `nfs-client-provisioner` | packaging of [`external-storage/nfs-client`](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client) | |
| `nginx-ingress` | [official](https://github.com/kubernetes/charts/tree/master/stable/nginx-ingress) | unchanged |
| `prometheus-operator` | CoreOS [prometheus-operator](https://github.com/coreos/prometheus-operator/tree/master/helm) | unchanged |
| `rocketchat` | [official](https://github.com/kubernetes/charts/tree/master/stable/rocketchat) | <ul><li>explicitly imported [`mongodb`](https://github.com/kubernetes/charts/tree/master/stable/mongodb) dependency</li><li>added config for default rocketchat admin account</li><li>added config for `nodeSelector`/`tolerations` to `rocketchat` and `mongodb`</li></ul> |
