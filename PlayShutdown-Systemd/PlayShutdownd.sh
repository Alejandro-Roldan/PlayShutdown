#!/bin/bash


############################################################################################
#
#  A SCRIPT TO HEADLESSLY CONTROL PLAYSHUTDOWN.SH
#
#    When no argument is given the script starts the systemd PlayShutdown.service as --user
#
#    When using the -c switch the script kills the systemd service
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
