Onion Services over Tailscale
=============================

![](./assets/StandWithUkraine.svg)

Private proxy to open Onion Services via Tailscale IPN

![Screenshot](assets/screenshot.png)


## Usage 

Run the container as follows:
```
$ podman run -d --rm --name tor \
  -e TAILSCALE_AUTH_KEY=tsnet... \
  ghcr.io/spotsnel/torscale:latest
```

and use 

```
$ tailscale ip -4 tor
```

and use eg. `100.123.45.67:9050` as the address of a SOCKS5 proxy in your browser.

Note: due to the limitations of webkit/chrome, you can not route DNS requests over
SOCKS5 unless you start the browser explicitly with this proxy. I would suggest
using Firefox with the FoxyProxy or SwitchyOmega extension.