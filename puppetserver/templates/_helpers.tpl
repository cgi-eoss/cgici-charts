{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "puppetserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "puppetserver.fullname" -}}
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
{{- define "puppetserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Value for PUPPETSERVER_HOSTNAME. Default is the full service name.
*/}}
{{- define "puppetserver.hostname" -}}
{{- .Values.puppetserverHostname | default (include "puppetserver.fullname" .) -}}
{{- end -}}

{{/*
Value for DNS_ALT_NAMES.
*/}}
{{- define "puppetserver.dnsAltNames" -}}
{{- prepend .Values.dnsAltNames (include "puppetserver.hostname" .) | uniq | join "," | quote -}}
{{- end -}}

{{- define "puppetserver.puppetdbDatabaseConnection" -}}
{{- .Values.puppetdb.puppetdbDatabaseConnection | default ( printf "//%s:%d/%s" (printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-") (.Values.postgresql.service.port | int) (.Values.postgresql.postgresqlDatabase) ) -}}
{{- end -}}