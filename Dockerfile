# Based on https://github.com/weldpua2008/docker-net-snmp
FROM telegraf

RUN export  DEBIAN_FRONTEND=noninteractive && \
     export DEBIAN_RELEASE=$(awk -F'[" ]' '/VERSION=/{print $3}'  /etc/os-release | tr -cd '[[:alnum:]]._-' ) && \
     echo "remove main from /etc/apt/sources.list" && \
     sed -i '/main/d' /etc/apt/sources.list && \
     echo "remove contrib from /etc/apt/sources.list" && \
     sed -i '/contrib/d' /etc/apt/sources.list && \
     echo "remove non-free from /etc/apt/sources.list" && \
     sed -i '/non-free/d' /etc/apt/sources.list && \
     echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE} main contrib non-free"  >> /etc/apt/sources.list && \
     echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE}-updates main contrib non-free"  >> /etc/apt/sources.list && \
     echo "deb http://security.debian.org ${DEBIAN_RELEASE}/updates main contrib non-free"  >> /etc/apt/sources.list && \
    set -x &&\
    apt-get update && \
    apt-get -y install snmp snmpd snmp-mibs-downloader && \
    rm -r /var/lib/apt/lists/*
    
COPY UBNT-FROGFOOT-RESOURCES-MIB.mib /usr/share/snmp/mibs/
COPY UBNT-MIB /usr/share/snmp/mibs/
COPY UBNT-UniFi-MIB /usr/share/snmp/mibs/
