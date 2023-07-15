{{/* Make sure all variables are set properly */}}
{{- include "replicated-library.values.setup" . }}

{{- define "hardcodedValues" -}}
apps:
  outline:
    containers:
      outline:
        image:
          repository: {{ .Values.outline.image.repository }}
          tag: {{ .Values.outline.image.tag }}
        env:
          SECRET_KEY: {{ required "secretKey is required" .Values.outline.secretKey }}
          UTILS_SECRET: {{ required "utilsSecret is required" .Values.outline.utilsSecret }}
          URL: {{ required "url is required" .Values.outline.url }}
          {{- if .Values.postgresql.enabled }}
            {{- $url := "initialized" }}
            {{- if .Values.postgresql.fullnameOverride }}
              {{- $url = .Values.postgresql.fullnameOverride }}
            {{- else }}
              {{- $url = print .Release.Name "-postgresql" }}
            {{- end }}
          DATABASE_URL: postgres://{{- .Values.postgresql.auth.username -}}:{{- .Values.postgresql.auth.password -}}@{{ $url }}:5432/{{ .Values.postgresql.auth.database }}
          DATABASE_URL_TEST: postgres://{{- .Values.postgresql.auth.username -}}:{{- .Values.postgresql.auth.password -}}@{{ $url }}:5432/{{ .Values.postgresql.auth.database }}-test
          {{- end }}
          {{ if .Values.redis.enabled }}
            {{- $url := "initialized" }}
            {{- if .Values.redis.fullnameOverride }}
              {{- $url = print .Values.redis.fullnameOverride "-master" }}
            {{- else }}
              {{- $url = print .Release.Name "-redis-master" }}
            {{- end }}
          REDIS_URL: redis://{{ $url }}:6379
          {{ end }}
          PORT: {{ .Values.outline.port }}
          PGSSLMODE: {{ .Values.outline.pgsslmode }}
          {{- if .Values.outline.oidc.clientId }}
          OIDC_CLIENT_ID: {{ .Values.outline.oidc.clientId }}
          OIDC_CLIENT_SECRET: {{ .Values.outline.oidc.clientSecret }}
          OIDC_AUTH_URI: {{ .Values.outline.oidc.authUri }}
          OIDC_TOKEN_URI: {{ .Values.outline.oidc.tokenUri }}
          OIDC_USERINFO_URI: {{ .Values.outline.oidc.userInfoUri }}
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