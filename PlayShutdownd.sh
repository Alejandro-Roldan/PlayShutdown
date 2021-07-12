#!/bin/bash


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
		nohup bash /home/Venus/Programs/Bash/Mpc/PlayShutdown.sh > /dev/null 2>&1 &
		;;
	*)
		echo "PlayShutdownd.sh: unrecognized option '$1'"
		echo
		help_msg
		exit 1
		;;
esac
