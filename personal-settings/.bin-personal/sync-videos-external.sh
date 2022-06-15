#!/bin/bash

# to external drive
rsync -av --progress --delete /home/brett/Videos/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Videos

# from external drive
#rsync -av --progress --delete /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Videos/ /home/brett/Videos
