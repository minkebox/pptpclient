#! /bin/sh

HOME_INTERFACE=${__HOME_INTERFACE}
INTERNAL_INTERFACE=${__PRIVATE_INTERFACE}
EXTERNAL_INTERFACE=tun0

/usr/sbin/pptpsetup --create ${HOSTNAME} --server ${SERVER} --username ${USER} --password ${PASSWORD} --encrypt
/usr/sbin/pppd call ${HOSTNAME}

trap "killall sleep pptpsetup pppd dnsmasq miniupnpd; exit" TERM INT

sleep 2147483647d &
wait "$!"
