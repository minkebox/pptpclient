#! /bin/sh

/bin/mknod /dev/ppp c 108 0

cat > /etc/ppp/peers/vpn << __EOF__
pty "pptp ${SERVER} --nolaunchpppd"
name "${USER}"
password "${PASSWORD}"
remotename PPTP
ipparam "vpn"
#require-mppe-128
refuse-pap
refuse-eap
refuse-chap
__EOF__

#/usr/sbin/pppd call vpn debug dump logfd 2 nodetach persist
/usr/sbin/pppd call vpn persist

trap "killall sleep pptpsetup perl pppd pptp dnsmasq miniupnpd; exit" TERM INT

sleep 2147483647d &
wait "$!"
