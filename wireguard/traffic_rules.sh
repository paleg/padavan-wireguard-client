#!/bin/sh

_enable() {
  . "$(dirname "$0")/conf.sh"
  
  _disable 2> /dev/null

  echo -n "Setting up WireGuard traffic rules... "

  iptables -t nat -A PREROUTING -d ${ADDR} -j vserver

  echo "done"
}

_disable() {
  . "$(dirname "$0")/conf.sh"

  echo -n "Removing WireGuard traffic rules... "

  iptables -t nat -D PREROUTING -d ${ADDR} -j vserver

  echo "done"
}

case "$1" in
  enable)
    _enable
    ;;

  disable)
    _disable
    ;;

  *)
    echo "Usage: $0 {enable|disable}" >&2
    exit 1
    ;;
esac

exit 0
