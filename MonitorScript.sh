SERVER="0.0.0.0"
ping -c 2 $SERVER &> /dev/null
if [ $? -ge 1 ]; then
	echo "Server down at $(date)" >> /var/log/serverdown.log
	echo "Server down at $(date)" | mailx -s "Server Down" <email@lol.com>
fi
