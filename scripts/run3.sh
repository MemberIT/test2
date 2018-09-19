#!/usr/bin/env bash
PATH='/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin'

vagrant up epl

curl -i http://epl.memberit.ru

echo 'Open url http://epl.memberit.ru !!!'

exit 0
