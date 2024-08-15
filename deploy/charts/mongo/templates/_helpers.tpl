{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Kubernetes and Helm standard labels.
*/}}
{{- define "common.labels" -}}
app.kubernetes.io/component: {{ .Values.component }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/part-of: {{ .Values.partOf }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ include "common.chart" . }}
{{- end -}}

{{/*
Return image for containers.
*/}}
{{- define "common.image" -}}
{{- $separator := ":" -}}
{{- $termination := .Values.image.tag | default .Chart.AppVersion -}}
{{- if .Values.image.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .Values.image.digest -}}
{{- end -}}
{{- if .Values.image.registry }}
    {{- printf "%s/%s%s%s" .Values.image.registry .Values.image.repository $separator $termination -}}
{{- else -}}
    {{- printf "%s%s%s" .Values.image.repository $separator $termination -}}
{{- end -}}
{{- end -}}
