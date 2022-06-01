#!/bin/sh

for i in `cat packages.txt`
do
  apk add --no-cache $i
done