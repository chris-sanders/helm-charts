# headscale

![Version: 0.0.1-beta.5](https://img.shields.io/badge/Version-0.0.1--beta.5-informational?style=flat-square)

headscale open source tailscale implementation

## Requirements

Kubernetes: `>=1.25.0-0`

## Dependencies
| Repository | Name | Version |
|------------|------|---------|
| https://replicatedhq.github.io/helm-charts | replicated-library | ^0.13.9 |

## Installing the Chart

This chart uses a library chart which enables significant customizations. Most of the deployment can be configured and changed if necessary. The default values provide most configuration options and should work for most installs.

### Versions
The chart will not attempt to keep up to date on image versions. Most updates to the image should not require changes to the chart. You can configure the repository and tag under the image tag:

```yaml
image:
  repository: ghcr.io/juanfont/headscale
  tag: 0.22.3
```

### Headscale config
The headscale config file is in yaml format and is set by the value `headscale.config`. You should set the `server_url` value to the external URL of your headscale server.

```yaml
headscale:
  config:
    server_url: https://your_url_here:port
```

You will need to configure ingress to forward this URL and port to the headscale service on port 8080. Headscale doesn't support reverse proxies and recommends a direct tcp port forward.

The entire config options can be set under the config key, see the upstream project for configuration values.

### Headscale ACL
The chart enables an ACL to allow all connections from all nodes and users similar to what tailscale uses by default. You can configure ACLs under the ACL key.

```yaml
headscale:
  acl:
    <your acl config here>
```

## Updating the README

We use [Helm Docs](https://github.com/norwoodj/helm-docs)

```
helm-docs -t README.md.gotmpl -t README_CHANGELOG.md.gotmpl -f values.yaml
```

## Changelog

Notable changes to this chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [Unreleased]

### [0.0.1]

#### Added

- Initial release

