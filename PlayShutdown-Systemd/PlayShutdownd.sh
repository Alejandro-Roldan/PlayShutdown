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
		systemctl --user stop PlayShutdown.service
		;;
	"")
		systemctl --user start PlayShutdown.service
		;;
	*)
		echo "PlayShutdownd.sh: unrecognized option '$1'"
		echo
		help_msg
		exit 1
		;;
esac
