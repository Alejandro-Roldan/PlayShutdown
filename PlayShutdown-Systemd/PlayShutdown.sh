#!/bin/bash


########
# MAIN #
########

set_flag(){
	# Set $flag to True when the current song position in the queue
	# is equal to the number of items in the queue
	# (aka the current song is the last song in the queue)
	if [[ $(mpc current --format %position%) -eq $(mpc playlist | wc -l) ]]; then
		flag=1
	else
		flag=0
	fi
}

# Initialize $flag
set_flag

# Check if queue has stopped (which also happens when queue has ended)
# (Using --wait mpc only outputs on song change so no need to set a sleep command)
# AND check if random is on OR $flag is True
# Further details on the logic bellow
until [[ -z $(mpc current --wait) && ( $(mpc status | grep "random: on") || $flag -eq "1" ) ]]; do
	set_flag
	echo flag $flag
done

# If it has stopped we understand the queue has ended and we can shutdown
shutdown now "MPD queue finished. Shutting Down..."


#########################################################################################################
#########################################################################################################

# We want the until loop to end when the queue has reached its end
# To know when the queue ends we can check mpc current, and if its empty, playing has stopped

# We also want to know if the previous song (before current didnt output) was the last one in queue
# To do that in each iteration of the loop check if the current song positions is equal to the number
# of queue items and set a flag accordingly to use in the next iteration of the loop 

# But if random is ON then that check doesnt actually tell us if its the end of the queue
# Because I havent found a way to check the end of the queue regardless of it being in random or not
# we only worry about that when random is OFF

# So we want to end the loop when current doesnt output AND the previous flag was True, BUT IF ONLY IF
# random is Off, otherwise just follow what current says

# current=C, random=R, flag=F
# Note: here current is negated (1 when doesnt output, 0 when it does output)

#  C|R|F||f
# ----------
#  0|0|0||0
#  0|0|1||0
#  0|1|0||0
#  0|1|1||0
#  1|0|0||0
#  1|0|1||1
#  1|1|0||1
#  1|1|1||1

# f(C,R,F)=C·(R+F)
