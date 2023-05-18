#!/bin/bash
/usr/sbin/insync start &
pid=$!
trap "kill $pid" SIGINT SIGTERM
wait $pid
