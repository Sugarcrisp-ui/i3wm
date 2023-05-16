#!/bin/bash

case "$1" in
  resume)
    sleep 10
    if ! pgrep -x "cryptomator" >/dev/null; then
      /usr/bin/cryptomator
    fi
    ;;
  *)
    if ! pgrep -x "cryptomator" >/dev/null; then
      sleep 10
      /usr/bin/cryptomator
    fi
    ;;
esac
