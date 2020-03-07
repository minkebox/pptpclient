#! /bin/sh

/bin/mknod /dev/ppp c 108 0
cat > /etc/ppp/peers/${HOSTNAME} << __EOF__
lock
pty "pptp ${SERVER} --nolaunchpppd"
name ${USER}
password ${PASSWORD}
remotename PPTP
ipparam "${HOSTNAME}"
require-mppe-128
__EOF__
/usr/sbin/pppd call ${HOSTNAME}

trap "killall sleep pptpsetup perl pppd dnsmasq miniupnpd; exit" TERM INT

sleep 2147483647d &
wait "$!"
