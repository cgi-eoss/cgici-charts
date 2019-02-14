#!/usr/bin/env bash
set -eux
SCRIPT=$(readlink -e "$0")
CHART_BASE=$(dirname "$SCRIPT")
REPO_PATH=$(dirname "$SCRIPT")/docs
REPO_URL='https://cgi-eoss.github.io/cgici-charts/'
PACKAGES=(
    'bazel-cache'
    'cert-manager'
    'dex'
    'dex-k8s-authenticator'
    'efs-provisioner'
    'elastic-stack'
    'elasticsearch'
    'fluentd-elasticsearch'
    'gerrit'
    'jenkins'
    'kube-prometheus'
    'kubernetes-dashboard'
    'log-stack'
    'nexus'
    'nfs-client-provisioner'
    'nginx-ingress'
    'prometheus-operator'
    'rocketchat'
    'simple-manifests'
    'spotify-docker-gc'
	'taiga'
)

if [ -n "${1:-}" ]; then
    helm package --destination=${REPO_PATH} --save=false "${CHART_BASE}/${1}"
else
    for pkg in ${PACKAGES[@]}; do
        helm package --destination=${REPO_PATH} --save=false "${CHART_BASE}/${pkg}"
    done
fi

helm repo index ${REPO_PATH} --url ${REPO_URL}
