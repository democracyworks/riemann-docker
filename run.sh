#!/bin/bash

set -e

if [[ -z $LIBRATO_KEY ]]; then
  echo "Set LIBRATO_KEY as your librato api key"
  exit 1
fi

echo "(def librato-key \"$LIBRATO_KEY\")" | cat - /etc/riemann/riemann.config > temp
mv temp /etc/riemann/riemann.config

/usr/bin/riemann /etc/riemann/riemann.config
