# PlayShutdown
A bash script to shutdown linux after end of MPD playlist is reached

There are two versions of this script: one where I implemented my own way of daemonization and another where I use systemd to handle that for me

## Playshutdown.sh
The main script. Does the checking and handles the logic (Check the file's comments for more information). Can even be used on it's own. In the systemd version it just does that; meanwhile in the other version it also creates a lock file where it saves the PID for easy retrival and keeps the script from being executed multiple times (by checking the existance of that lock file). I would place it inside /opt so it's in a regular directory but not in $PATH, and have the daemonizer in a directory that is in $PATH (like /usr/local/bin) (This to not have them both inside $PATH so autocompletition when wanting to execute is easier)

## Playshutdownd.sh
The script to daemonize the main script. In the systemd version starts the service and with a -c argument stops it. In the regular version launches the script headlessly and -c retrives the PID from the lockfile, retrives the PGID with it and kills the group.

## PlayShutdown.service
A basic systemd service for Playshutdown.

To be able to execute it without needing to enter the password each time, use as systemd --user (therefore needing to place the service in ~/.config/systemd/user)
