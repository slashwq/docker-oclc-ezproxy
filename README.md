# docker-oclc-ezproxy

[![GitHub issues](https://img.shields.io/github/issues/hyp5r/docker-oclc-ezproxy?style=for-the-badge&logo=github)](https://github.com/hyp5r/docker-oclc-ezproxy/issues) [![GitHub stars](https://img.shields.io/github/stars/hyp5r/docker-oclc-ezproxy?style=for-the-badge&logo=github)](https://github.com/hyp5r/docker-oclc-ezproxy/stargazers) [![GitHub forks](https://img.shields.io/github/forks/hyp5r/docker-oclc-ezproxy?style=for-the-badge&logo=github)](https://github.com/hyp5r/docker-oclc-ezproxy/network) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/hyp5r/oclc-ezproxy?style=for-the-badge&logo=docker)

*A Docker container based on Debian that runs the OCLC EZproxy software.*

## Running the Container
### Docker

**RECOMMENDED:** Using the Docker *host* network:

```sh
docker run -h HOSTNAME.TLD -v PATH_TO_EZPROXY_CONFIG_FOLDER:/usr/local/ezproxy/config --network=host hyp5r/oclc-ezproxy
```

Using the *host* network is recommended for OCLC EZproxy as the config.txt file within the EZproxy config handles exposed ports. Because this is a proxy software, the ports must match exactly what's exposed, and any mismatch between Docker's exposed ports and the ports exposed in config.txt will cause a redirect issue.

OCLC EZproxy is not compatible with a reverse proxy, also making the Docker *host* network more suitable. If you already use port 80/443 on your Docker host, you'll need a second IP address and configure EZproxy's config.txt to bind to that specific IP.

**NOT RECOMMENDED:** Using the Docker *bridge* network and exposing the default port:

```sh
docker run -h HOSTNAME.TLD -v PATH_TO_EZPROXY_CONFIG_FOLDER:/usr/local/ezproxy/config -p 2048:2048 hyp5r/oclc-ezproxy
```

### Docker Compose

```yaml
version: 3

services:
  ezproxy:
    image: hyp5r/oclc-ezproxy
    container_name: oclc-ezproxy
    network_mode: host
    hostname: HOSTNAME.TLD
    restart: unless-stopped
    environment:
      - TZ=YOUR_TIMEZONE_HERE
      - EZPROXY_WSKEY=YOUR_EZPROXY_WSKEY_HERE
### Ports commented out as network_mode is host
#   ports:
#     - 2048:2048
    volumes:
      - PATH_TO_EZPROXY_CONFIG_FOLDER:/usr/local/ezproxy/config
```

* **container_name** can be anything you'd like to name the container.
* **network_mode** is recommended to be *host*. Set to *bridge* and uncomment the *ports* config if you'd rather expose ports, but be warned that EZproxy may not function correctly if your EZproxy config is incorrect.
* **hostname** needs to be a FQDN. For most colleges, this may be something like *ezproxy.myschool.edu*, but the hostname must be applied or EZproxy will not route traffic properly.