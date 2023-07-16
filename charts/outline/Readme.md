# Outline

This is a chart for [outlinewiki](https://github.com/chsasank/outline-wiki-docker-compose) self hosted.

## Ingress

This chart doesn't setup ingress. You'll need to configure your ingress controller to route to the outline service and minio (port 9000) if you enable it.

## S3

If you enable minio for S3 you need to configure `outline.s3.url` this needs to be publicly accessible (setup an ingress to minio service on port 9000). Outline redirects clients to upload here.

Additionally, you need to log into the minio console (port 9001 via browser) with your key and secret key and add a bucket for outline to use. This is set to `outline-bucket` by default after creating the bucket file uploads work. Note that the bucket name `outline` is know to not work.

Finally you will need to log into the minio cloud and set the public policy on the public portion of the minio bucket. From the pod run: 
`mc alias set minio http://localhost:9000 your-minio-access-key your-minio-secret`
`mc anonymous set public minio/outline-bucket/public`

Minio keys require a string > 8 characters long, and the pod will simply fail to start if not provided.

The minio chart doesn't seem to work with SMB mounts. It might be a file permission issue, but using iscsi for a volume works fine. As above there is no error if this is the problem, the pod will simply fail to add the host and start.

## SSO

This chart doesn't setup SSO, it provides the env to configure OIDC and this is working with Keycloak. Bitnami maintains a Keycloak chart.

## ENV

Any environment variables that aren't set by the chat can be set with the extraEnv config. These get passed directly to the outline container, see outlinewiki documentation for additional configuration.

## Contributions

This chart was written for personal use, contributions are welcome, and simple bug reports will be reviewed and fixed if reasonable to do so.

