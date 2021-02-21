{{/*
Expand the name of the chart.
*/}}
{{- define "taiga.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "taiga.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "taiga.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "taiga.labels" -}}
helm.sh/chart: {{ include "taiga.chart" . }}
{{ include "taiga.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "taiga.selectorLabels" -}}
app.kubernetes.io/name: {{ include "taiga.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return  the proper Storage Class
*/}}
{{- define "taiga.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.persistence "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "taiga.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.taigaBack.image .Values.taigaFront.image .Values.taigaEvents.image .Values.taigaProtected.image .Values.taigaGateway.image) "global" .Values.global) -}}
{{- end -}}


{{/*
Get the user defined LoadBalancerIP for this release.
Note, returns 127.0.0.1 if using ClusterIP.
*/}}
{{- define "taiga.serviceIP" -}}
{{- if eq .Values.service.type "ClusterIP" -}}
127.0.0.1
{{- else -}}
{{- .Values.service.loadBalancerIP | default "" -}}
{{- end -}}
{{- end -}}

{{/*
Gets the host to be used for this application.
If not using ClusterIP, or if a host or LoadBalancerIP is not defined, the value will be empty.
When using Ingress, it will be set to the Ingress hostname.
*/}}
{{- define "taiga.host" -}}
{{- if .Values.ingress.enabled }}
{{- $host := .Values.ingress.hostname | default "" -}}
{{- default (include "taiga.serviceIP" .) $host -}}
{{- else -}}
{{- $host := index .Values (printf "%sHost" .Chart.Name) | default "" -}}
{{- default (include "taiga.serviceIP" .) $host -}}
{{- end -}}
{{- end -}}

{{- define "taiga.protocol" -}}
{{ ternary "https" "http" .Values.ingress.tls }}
{{- end -}}

{{- define "taiga.wsProtocol" -}}
{{ ternary "wss" "ws" .Values.ingress.tls }}
{{- end -}}

{{- define "taiga.asyncBrokerUrl" -}}
{{- printf "amqp://%s:%s@%s:%s/taiga" .Values.rabbitmqasync.auth.username .Values.rabbitmqasync.auth.password "taiga-async-rabbitmq" (.Values.rabbitmqasync.service.port | toString) -}}
{{- end -}}