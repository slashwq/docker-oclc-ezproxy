# docker-oclc-ezproxy

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


```