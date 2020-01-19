#!/bin/sh

mkdir /tmp/dev
cd /tmp/dev
echo "-- installing dev tools --"

yum -y groupinstall 'Development Tools'
yum -y install git which
yum install -y openssl-devel


echo "installing rtmpdump"
git clone git://git.ffmpeg.org/rtmpdump
cd rtmpdump
make
make install
cd ..

export LD_LIBRARY_PATH="/opt/glibc-2.14/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}:/usr/local/lib"
ldconfig

echo "installing curl"
git clone https://github.com/curl/curl.git
cd curl
./buildconf
./configure --with-ssl --with-libssl-prefix=/usr/local/ssl --with-librtmp=/usr/local/lib
make
make install
cd ..


echo "-- done installing dev tools --"
