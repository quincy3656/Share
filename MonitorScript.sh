#!/bin/bash
#Created by Quinton Brown

#Main Variables
#Cam server:
#SERVER="127.0.0.1"
#Gaming PC:
#SERVER2="127.0.0.1"

#Cam Server ping check:
ping -c 2 $SERVER &> /dev/null
if [ $? -ge 1 ]; then
	echo "Cam server unreachable at $(date)" >> /var/log/serverdown.log
	#	echo "Cam server unreachable at $(date)" | mailx -s "Server Down" email@domain.com
fi
#Gaming PC ping check:
ping -c 2 $SERVER2 &> /dev/null
if [ $? -ge 1 ]; then
	echo "Gaming computer unreachable at $(date)" >> /var/log/serverdown.log
	#       echo "Gaming computer unreachable at $(date)" | mailx -s "Server Down" email@domain.com

fi
