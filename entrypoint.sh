#!/bin/sh

/etc/init.d/cron start
/etc/init.d/rsyslog start
/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng foreground=1
