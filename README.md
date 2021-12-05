# Simple TURN Watchdog
Send a mail notification if no TURN relay candidates on a given TURN URI are returned. Check's a TURN server regulary based on a defined interval in seconds.
Basically, a simple wrapper script around the WebRTC samples Trickle ICE, refer to https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/. Refer to https://hub.docker.com/repository/docker/mm28ajos/simple-turn-watchdog for pre-build docker images (under construction).

## Features
* check TURN server for relay candidates
* define delay of recheck in seconds
* generate TURN credentials from TURN secret
* use TURN username and password

# Example Notification

Mail on TURN error.
```
Subject: TURN Watchdog detected failure on URI: 'turns:turn.example.com:5349'
Body: empty
```

## Getting started
### Docker Compose
Create a docker compose file, see an example below or in example folder.

```
version: '2.2'
services:
  turn_watchdog:
    container_name: turn_watchdog
    image: mm28ajos/simple-turn-watchdog:latest
    restart: unless-stopped
    volumes:
      - /path/to/.env:/usr/src/app/.env:ro
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

# the SMTP settings
MAIL_SMTP_HOST=smtp.example.com
MAIL_SMTP_USER=user@example.com
MAIL_SMTP_PASSWORD=hoisdhdshihiopsd
MAIL_FROM=user@example.com
MAIL_TO=user2@example.com

# deplay in seconds before rechecking the TURN server
DELAY_SEC=600
```
