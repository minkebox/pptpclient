#! /bin/sh

/bin/mknod /dev/ppp c 108 0

if [ "${PAP}" = "true" ]; then
  PAP=""
else
  PAP="refuse-pap"
fi
if [ "${EAP}" = "true" ]; then
  EAP=""
else
  EAP="refuse-eap"
fi
if [ "${CHAP}" = "true" ]; then
  CHAP=""
else
  CHAP="refuse-chap"
fi
if [ "${MSCHAP}" = "true" ]; then
  MSCHAP=""
else
  MSCHAP="refuse-mschap"
fi
if [ "${MPPE}" = "true" ]; then
  MPPE="require-mppe-128"
else
  MPPE=""
fi

cat > /etc/ppp/peers/vpn << __EOF__
pty "pptp ${SERVER} --nolaunchpppd"
name "${USER}"
password "${PASSWORD}"
remotename PPTP
ipparam "vpn"
${MPPE}
${PAP}
${EAP}
${CHAP}
${MSCHAP}
__EOF__

#/usr/sbin/pppd call vpn debug dump logfd 2 nodetach persist
/usr/sbin/pppd call vpn persist

trap "killall sleep pptpsetup perl pppd pptp dnsmasq miniupnpd; exit" TERM INT

sleep 2147483647d &
wait "$!"
