{{/* vim: set filetype=mustache: */}}
{{/* chart specific names and labels that may be re-used in the chart */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "adotCollector.daemonSet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "adotCollector.deployment.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "adotCollector.daemonSet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "adotCollector.commonLabels" }}
helm.sh/chart: {{ include "adotCollector.daemonSet.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: opentelemetry
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}



{{/*
Daemonset Common labels
*/}}
{{- define "adotCollector.daemonSet.commonLabels" }}
{{- include "adotCollector.daemonSet.selectorLabels" . }}
{{- include "adotCollector.commonLabels" . }}
app.kubernetes.io/part-of: {{ template "adotCollector.daemonSet.name" . }}
{{- if .Values.adotCollector.daemonSet.additionalLabels }}
{{ toYaml .Values.adotCollector.daemonSet.additionalLabels }}
{{- end }}
{{- end }}

{{/*
Daemonset Common labels
*/}}
{{- define "adotCollector.deployment.commonLabels" }}
{{- include "adotCollector.deployment.selectorLabels" . }}
{{- include "adotCollector.commonLabels" . }}
app.kubernetes.io/part-of: {{ template "adotCollector.daemonSet.name" . }}
{{- if .Values.adotCollector.deployment.additionalLabels }}
{{ toYaml .Values.adotCollector.deployment.additionalLabels }}
{{- end }}
{{- end }}


{{/*
Daemonset Selector labels
*/}}
{{- define "adotCollector.daemonSet.selectorLabels" }}
app.kubernetes.io/name: {{ include "adotCollector.daemonSet.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Deployment Selector labels
*/}}
{{- define "adotCollector.deployment.selectorLabels" }}
app.kubernetes.io/name: {{ include "adotCollector.deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


