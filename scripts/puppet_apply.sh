#!/usr/bin/env bash
PATH='/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin'

exit_status() {
  STATUS=$?
  if [ "${STATUS}" = "0" -o "${STATUS}" = "2" ]; then
    exit 0
  else
    exit $STATUS
  fi
}

DIRECTORY='/etc/puppetlabs/code/environments/production'
OPTIONS="--hiera_config=${DIRECTORY}/hiera.yaml --modulepath=${DIRECTORY}/modules:${DIRECTORY}/sites ${DIRECTORY}/manifests --show_diff"

puppet apply $OPTIONS --environment=production --summarize
exit_status
