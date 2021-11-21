#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s /home/brett/Videos/movies/ /mnt/057c65a9-7f0e-4e18-a733-74d60d7c1e5e/videos/movies --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/Videos/tv/ /mnt/057c65a9-7f0e-4e18-a733-74d60d7c1e5e/videos/tv --delete
