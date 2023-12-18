#!/bin/bash

domain="$1"

if [ -s html/$domain.html ] ; then
  echo "Skipping domain $domain"
  exit 0;
fi

echo "Fetching domain: $domain"
curl -sL $domain -o html/$domain.html
