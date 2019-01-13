#!/bin/bash

LOG=log.strace

rm log.strace -f

echo -e "\033[32m do strace download start\033[0m"
wget https://strace.io/files/4.26/strace-4.26.tar.xz >> $LOG
[ $? -ne 0 ] && return 1
echo -e "\033[32m do strace download end\033[0m"

echo -e "\033[32m do strace uncompress start\033[0m"
tar xf strace-4.26.tar.xz >> $LOG
[ $? -ne 0 ] && return 2
echo -e "\033[32m do strace uncompress end\033[0m"

cd strace-4.26 >> $LOG
[ $? -ne 0 ] && return 3

echo -e "\033[32m do strace config start\033[0m"
./configure --prefix=`pwd`/obj --host=arm-linux-gnueabi CC=arm-linux-gnueabi-gcc LD=arm-linux-gnueabi-ld >> $LOG
[ $? -ne 0 ] && return 4
echo -e "\033[32m do strace config end\033[0m"

echo -e "\033[32m do strace build start\033[0m"
make >> $LOG
[ $? -ne 0 ] && return 5
echo -e "\033[32m do strace build end\033[0m"

echo -e "\033[32m do strace install start\033[0m"
make install >> $LOG
[ $? -ne 0 ] && return 6
cp obj/bin/* ../../busybox/rootfs/usr/bin/ >> $LOG
[ $? -ne 0 ] && return 7
echo -e "\033[32m do strace install end\033[0m"

cd .. >> $LOG
[ $? -ne 0 ] && return 8

return 0

