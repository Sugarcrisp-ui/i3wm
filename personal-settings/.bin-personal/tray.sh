#!/bin/bash

pkill -q cyptomator.AppImage
pkill -q insync

cryptomator.AppImage &
insync start &
