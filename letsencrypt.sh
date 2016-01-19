#!/bin/bash

cd /var/ssl
/root/letsencrypt.sh/letsencrypt.sh -c
rm certs.tgz > /dev/null 2>&1; rm certs.tgz.cpt; tar zcf certs.tgz certs
if [ -f /var/ssl/ccryptkey ]; then
  ccencrypt -K `cat ccryptkey` certs.tgz
fi
