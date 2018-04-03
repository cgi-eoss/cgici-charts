#!/usr/bin/env bash

SCRIPT=$(readlink -e "$0")
CHART_BASE=$(dirname "$SCRIPT")
REPO_PATH=$(dirname "$SCRIPT")/docs
REPO_URL='https://cgi-eoss.github.io/cgici-charts/'
PACKAGES=(
    'cert-manager'
    'dex'
    'dex-k8s-authenticator'
    'jenkins'
    'kubernetes-dashboard'
    'nexus'
    'nginx-ingress'
)

for pkg in ${PACKAGES[@]}; do
    helm package --destination=${REPO_PATH} --save=false "${CHART_BASE}/${pkg}"
done

helm repo index ${REPO_PATH} --url ${REPO_URL}
