{{/* Make sure all variables are set properly */}}
{{- include "replicated-library.values.setup" . }}

{{- define "hardcodedValues" -}}
apps:
  outline:
    containers:
      outline:
        env:
          SECRET_KEY: {{ required "secretKey is required" .Values.outline.secretKey }}
          UTILS_SECRET: {{ required "utilsSecret is required" .Values.outline.utilsSecret }}
          URL: {{ required "url is required" .Values.outline.url }}
          {{- if .Values.postgresql.enabled }}
          DATABASE_URL: postgres://{{- .Values.postgresql.auth.username -}}:{{- .Values.postgresql.auth.password -}}@{{ .Release.Name }}-postgresql:5432/{{ .Values.postgresql.auth.database }}
          DATABASE_URL_TEST: postgres://{{- .Values.postgresql.auth.username -}}:{{- .Values.postgresql.auth.password -}}@{{ .Release.Name }}-postgresql:5432/{{ .Values.postgresql.auth.database }}-test
          {{- end }}
          {{ if .Values.redis.enabled }}
          REDIS_URL: redis://{{ .Release.Name }}-redis-master:6379
          {{ end }}
          PORT: {{ .Values.outline.port }}
          {{- if .Values.outline.oidc.clientId }}
          OIDC_CLIENT_ID: {{ .Values.outline.oidc.clientId }}
          OIDC_CLIENT_SECRET: {{ .Values.outline.oidc.clientSecret }}
          OIDC_AUTH_URI: {{ .Values.outline.oidc.authUri }}
          OIDC_TOKEN_URI: {{ .Values.outline.oidc.tokenUri }}
          OIDC_USERINFO_URI: {{ .Values.outline.oidc.userinfoUri }}
          OIDC_USERNAME_CLAIM: {{ .Values.outline.oidc.usernameClaim }}
          OIDC_DISPLAY_NAME: {{ .Values.outline.oidc.displayName }}
          OIDC_SCOPES: {{ .Values.outline.oidc.scopes }}
          {{- end }}
          {{- range $k, $v := .Values.outline.extraEnv }}
          {{ $k }}: {{ $v }}
          {{- end }}
{{ end }}
{{ $_ := mergeOverwrite .Values (include "hardcodedValues" . | fromYaml) }}

{{ include "replicated-library.all" . }}
