#!/bin/sh

echo 'Starting up Tailscale...'

/app/tailscaled --verbose=1 --port 41641 --tun=userspace-networking --socks5-server=localhost:3215 &
sleep 5
if [ ! -S /var/run/tailscale/tailscaled.sock ]; then
    echo "tailscaled.sock does not exist. exit!"
    exit 1
fi

until /app/tailscale up \
    --authkey=${TAILSCALE_AUTH_KEY} \
    --hostname=tor \
    --ssh
do
    sleep 0.1
done

echo 'Tailscale serve Tor proxy...'

/app/tailscale serve tcp:9050 tcp://localhost:9050
/app/tailscale serve tcp:9051 tcp://localhost:9051

echo 'Tailscale started'

echo 'Starting up Tor...'

if [ "$1" != "" ]; then
  exec "$@"
else
  mkdir -p /var/lib/tor/hidden_service
  chmod 700 /var/lib/tor/hidden_service
  chown -R tor:nogroup /var/lib/tor
  while true; do
    su -s /bin/sh -c '/usr/bin/tor -f /etc/tor/torrc --runasdaemon 0' tor
    echo "Restarting tor service"
    sleep 2s
  done
fi


