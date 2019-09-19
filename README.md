# fireblink/fbl-plugins Docker Image

[![CircleCI](https://circleci.com/gh/FireBlinkLTD/fbl-docker-image.svg?style=svg)](https://circleci.com/gh/FireBlinkLTD/fbl-docker-image)
[![Greenkeeper badge](https://badges.greenkeeper.io/FireBlinkLTD/fbl-docker-image.svg)](https://greenkeeper.io/)

Fat image with FBL and all officially supported plugins.

**Links:**
- [Docker Hub](https://hub.docker.com/r/fireblink/fbl-plugins)
- [Repository](https://github.com/FireBlinkLTD/fbl-docker-image)
- [FBL Documentaion](https://fbl.fireblink.com)
- Plugin documentation are located inside GitHub repository of each individual plugin. You can find repositories inside [FireBlinkLTD](https://github.com/FireBlinkLTD) organization page.

Docker image builds are fully automated. Whenever new version of one of the plugins or fbl itself released [package.json](./package.json) is updated automatically and new tag gets created.

Make sure to always use version tag instead of `latest`. That tag is mostly designed for testing purposes and is not suitable for production usage.

You may find what fbl, plugins and what versions are included in the build by looking into [GitHub releases](https://github.com/FireBlinkLTD/fbl-docker-image/releases) with associated tag version.

## Kubernetes Tools

`kubectl` and `helm` are included to support `@fbl-plugins/k8s-kubectl` and `@fbl-plugins/k8s-helm` plugins.

## Docker Compose Example

```yaml
version: '3'

services:
  fbl:
    # For demo purposes `latest` tag is used, however it is highly advised to use fixed version 
    image: fireblink/fbl-plugins:latest
    volumes:
      - ./path/to/fbl/scripts:/usr/fbl
    command: fbl /usr/fbl/flow.yml --verbose
```