# docker-oclc-ezproxy

*A Docker container based on Debian that runs the OCLC EZproxy software.*

## Running the Container
### Docker

**RECOMMENDED:** Using the Docker *host* network:
```sh
docker run -h HOSTNAME.TLD -v PATH_TO_EZPROXY_CONFIG_FOLDER:/usr/local/ezproxy/config --network=host hyp5r/oclc-ezproxy
```

**NOT RECOMMENDED:** Using the Docker *bridge* network and exposing the default port:
```sh
docker run -h HOSTNAME.TLD -v PATH_TO_EZPROXY_CONFIG_FOLDER:/usr/local/ezproxy/config -p 2048:2048 hyp5r/oclc-ezproxy
```