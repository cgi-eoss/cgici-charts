{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gerrit.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gerrit.fullname" -}}
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
{{- define "gerrit.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Extra initialisation commands to run in the init container.
{{- $extraArgs := .Values.init.extraCommands | default "" | (printf " && %s" (join " && " .Values.init.extraCommands)) -}}
*/}}
{{- define "gerrit.init.args" -}}
["-c", "if [ ! -e /var/gerrit/etc/gerrit.config ]; then java -jar /var/gerrit/bin/gerrit.war init -d /var/gerrit --batch --install-all-plugins ; fi{{ range .Values.init.extraCommands }}{{ printf " && %s" . }}{{end}}"]
{{- end -}}
