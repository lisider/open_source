#!/bin/bash

CURRENT_PATH=`pwd`
rm fail.list -f

Strace(){
	echo -e "\033[32m Do strace ... Start\033[0m"
	source strace.sh
	RET=$?
	[ $RET -ne 0 ] && echo strace $RET >> fail.list && cd $CURRENT_PATH && echo -e "\033[5;31m strace  FAIL $RET\033[0m" && sleep 1
	echo -e "\033[32m Do strace ... End\033[0m"
}

Main(){
	echo -e "\033[32m DO START\033[0m"
	Strace
	echo -e "\033[32m DO END\033[0m"

}

Main $*
