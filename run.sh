#!/bin/bash

set -e

if [[ -z $LIBRATO_KEY || -z $LIBRATO_EMAIL ]]; then
  echo "Set LIBRATO_EMAIL as your librato email address and LIBRATO_KEY as your librato api key"
  exit 1
fi

if [[ -n $HIPCHAT_TOKEN && -n $HIPCHAT_ROOM ]]; then
  echo "(def hipchat-token \"$HIPCHAT_TOKEN\") (def hipchat-room \"$HIPCHAT_ROOM\")" | cat - /etc/riemann/riemann.config > temp
  mv temp /etc/riemann/riemann.config
fi

echo "(def librato-email \"$LIBRATO_EMAIL\")(def librato-key \"$LIBRATO_KEY\")" | cat - /etc/riemann/riemann.config > temp
mv temp /etc/riemann/riemann.config

/usr/bin/riemann /etc/riemann/riemann.config
