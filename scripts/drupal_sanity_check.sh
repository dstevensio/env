#!/bin/bash

SERVERS=( drupal01.zappos.net drupal02.zappos.net drupal03.zappos.net )
ZAPPOS_HOST_HEADER="drupal.zappos.net"
SIXPM_HOST_HEADER="6pmdrupal.zappos.net"
ZAPPOS_PAGES=( d/zappos-homepage d/shoes d/clothing d/bags d/housewares d/watches d/new-arrivals )
SIXPM_PAGES=( c/homepage c/shoes c/clothing c/bags c/accessories c/clearance c/general-questions )
TIMESTAMP=`date "+%s"`

function curl_request {
  echo curl -I -H "Host: $1" http://$2/$3?$TIMESTAMP
  echo ""
  curl -I -H "Host: $1" http://$2/$3?$TIMESTAMP
}

for server in "${SERVERS[@]}"; do
  for page in "${ZAPPOS_PAGES[@]}"; do
    curl_request ${ZAPPOS_HOST_HEADER} $server $page
  done

  for page in "${SIXPM_PAGES[@]}"; do
    curl_request ${SIXPM_HOST_HEADER} $server $page
  done
done

