#!/bin/bash

set -e

mounts="${@}"

for mnt in "${mounts[@]}"; do
  src=$(echo $mnt | awk -F':' '{ print $1 }')
  mkdir -p $src
  if (more /etc/exports | grep "$src *"); then
    echo exist
  else
    echo "$src *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
  fi
done

exec runsvdir /etc/sv
