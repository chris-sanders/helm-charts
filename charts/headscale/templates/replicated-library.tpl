{{/* Make sure all variables are set properly */}}
{{- include "replicated-library.values.setup" . }}

{{- define "hardcodedValues" -}}
apps:
  headscale:
    containers:
      headscale:
        image:
          repository: {{ .Values.image.repository }}
          tag: {{ .Values.image.tag }}

configmaps:
  headscale:
    data:
{{- $headscaleConfig := .Values.headscale.config | toYaml | trim }}
      etc: | 
{{ $headscaleConfig | indent 8 }}
{{ end }}
{{ $_ := mergeOverwrite .Values (include "hardcodedValues" . | fromYaml) }}

{{ include "replicated-library.all" . }}
