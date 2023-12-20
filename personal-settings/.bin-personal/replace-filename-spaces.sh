#!/bin/bash

# This script will replace the spaces in file names with '-'

for file in *; do
    mv "$file" `echo $file | tr ' ' '-'`
done
