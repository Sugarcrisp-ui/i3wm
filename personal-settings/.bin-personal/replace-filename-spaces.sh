#!/bin/bash

for file in *; do
    mv "$file" `echo $file | tr ' ' '-'`
done
