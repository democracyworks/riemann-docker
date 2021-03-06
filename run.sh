#!/bin/bash

set -e

if [[ -z $LIBRATO_KEY || -z $LIBRATO_EMAIL ]]; then
  echo "Set LIBRATO_EMAIL as your librato email address and LIBRATO_KEY as your librato api key"
  exit 1
fi

if [[ -n $SLACK_WEBHOOK_URI ]]; then
  echo "(def slack-webhook-uri \"$SLACK_WEBHOOK_URI\")" | cat - /etc/riemann/riemann.config > temp
  mv temp /etc/riemann/riemann.config
fi

echo "(def librato-email \"$LIBRATO_EMAIL\")(def librato-key \"$LIBRATO_KEY\")" | cat - /etc/riemann/riemann.config > temp
mv temp /etc/riemann/riemann.config

/usr/bin/riemann /etc/riemann/riemann.config
