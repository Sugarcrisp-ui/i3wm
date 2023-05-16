#!/bin/bash

case "$1" in
  resume)
    sleep 10
    if ! pgrep -x "insync" >/dev/null; then
      /usr/bin/insync start
    fi
    ;;
  *)
    if ! pgrep -x "insync" >/dev/null; then
      sleep 10
      /usr/bin/insync start
    fi
    ;;
esac
