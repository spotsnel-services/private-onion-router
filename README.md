Private Tor over Tailscale
==========================

## Usage 

Run the container as follows:
```
$ podman run -d --rm --name tor -e TAILSCALE_AUTH_KEY=tsnet... ghcr.io/spotsnel/torscale:latest
```

and use `tailscale ip -4 tor`:9050 as the address of a SOCKS5 proxy in your browser

