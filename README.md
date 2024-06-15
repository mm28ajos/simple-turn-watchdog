# Simple TURN Watchdog

![Docker Pulls](https://img.shields.io/docker/pulls/mm28ajos/simple-turn-watchdog.svg)
![Docker Builds](https://github.com/mm28ajos/simple-turn-watchdog/actions/workflows/build-images.yml/badge.svg)

Exposes a HTTP status page which reflects the health of the turn server. Status code 200 indicates that relay candidates are sent by the TURN server, a status code of 503 indicates no relay candidates were sent.  This status page can be monitored by third party tools such as [Kuma Monitor](https://github.com/louislam/uptime-kuma). Check's a TURN server regulary based on a defined interval in seconds.
Basically, a simple wrapper script around the WebRTC samples Trickle ICE, refer to https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/.

## Docker Hub
Refer to https://hub.docker.com/r/mm28ajos/simple-turn-watchdog for pre-build docker images.

## Features
* check TURN server for relay candidates
* define delay of recheck in seconds
* generate TURN credentials from TURN secret
* use TURN username and password
* HTTP status page to included the TURN check e.g. in Kuma Monitor

## Supported Tags an Architectures
Supported tags:

* **latest** build from new last commit in master branch or monthly rebuild based on last commit on master branch.
* **X.Y.Z** build from the release with respective tag vX.Y.Z. No regular rebuild. Build once and no update.

Currently supported architectures:
* linux/amd64
* linux/arm/v7
* linux/arm64

## Getting started
### Docker Compose
Create a docker compose file, see an example below or in example folder.

```
services:
  turn_watchdog:
    container_name: turn_watchdog
    image: mm28ajos/simple-turn-watchdog:latest
    restart: unless-stopped
    volumes:
      - /path/to/.env:/usr/src/app/.env:ro
    environment:
      - TZ=Europe/Berlin
```

### Configuration

Mount an env file to **/usr/src/app/.env**, refer to example below or in example folder.

```
# (choice) the TURN server secret, alternativly, supply TURN_PASSWORD and TURN_USERNAME. TURN_SECRET has priority over TURN_USERNAME and TURN_PASSWORD if both are specified.
TURN_SECRET=d0174558c63ab84a3880827604e1bb2f7019bba05bdd6bc7b54f45ab3621f381
# (choice) the TURN username, alternativly, supply TURN_SECRET. 
TURN_USERNAME=username
# (required if TURN_USERNAME is defined) the TURN password
TURN_PASSWORD=password

# the URI of the TURN server to check 
TURN_URI=turns:turn.example.com:5349

# deplay in seconds before rechecking the TURN server
DELAY_SEC=600
```
