{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "taiga.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "taiga.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "taiga.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
  Create a default fully qualified postgresql name.
  We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create taiga URL string
*/}}
{{- define "taiga.baseurl" -}}
{{- printf "%s://%s" .Values.taigaProtocol .Values.taigaHostname -}}
{{- end -}}

{{- define "taiga.websocketProtocol" -}}
{{- if eq .Values.taigaProtocol "https" -}}wss{{- else -}}ws{{- end -}}
{{- end -}}

{{- define "taiga.rabbitmqUrl" -}}
{{- printf "amqp://%s:%s@%s-%s:%d/" .Values.rabbitmq.rabbitmq.username .Values.rabbitmq.rabbitmq.password .Release.Name ("rabbitmq" | trunc 63 | trimSuffix "-") (int .Values.rabbitmq.service.port) -}}
{{- end -}}
{{- define "taiga.redisUrl" -}}
{{- printf "redis://%s-%s:%d/" .Release.Name ("redis-master" | trunc 63 | trimSuffix "-") (int .Values.redis.master.service.port) -}}
{{- end -}}