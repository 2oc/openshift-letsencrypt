#!/bin/bash

# install letsencrypt if not in persistentvolume
if [ ! -f /var/ssl/config.sh ]; then
  cp -vfpr /tmp/ssl/* /var/ssl/
fi

cd /var/ssl
#/root/letsencrypt.sh/letsencrypt.sh -c

sleep 3600
