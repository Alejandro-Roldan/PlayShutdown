#!/bin/bash


############################################################################################
#
#  A SCRIPT TO HEADLESSLY CONTROL PLAYSHUTDOWN.SH
#
#    When no argument is given the script starts headlessly PlaySHutdown.sh
#
#    When using the -c switch the script reads the PID from the created lock file and uses
#    it to get the PGID to kill the whole group.
#
#    When any other argument is given raises an error and prints a help message.
#
############################################################################################


help_msg(){
	echo "Usage:"
	echo " PlayShutdown.sh [options]"
	echo
	echo "Options:"
	echo " -c --cancel Cancel a pending shutdown"
}

case $1 in
	-c | --cancel)
		# Read PID from the lock file
		pid=$(cat /tmp/playshtdwn.lock)
		# Get PGID from PID
		# -o is the format (we are just asking for the pgid), returns value with leading spaces
		# xargs strips spaces from the output
		pgid=$(ps -o pgid= $pid | xargs)
		kill -- -$pgid
		;;
	"")
		nohup bash /opt/PlayShutdown.sh > /dev/null 2>&1 &
		;;
	*)
		echo "PlayShutdownd.sh: unrecognized option '$1'"
		echo
		help_msg
		exit 1
		;;
esac
