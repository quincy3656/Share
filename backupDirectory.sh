#!/bin/bash
#Backup a directory if there is a difference from the last backup.
#You can edit the variables as needed, other than that the script takes care of the rest! This is best pared with a cron entry or cronjob.
#Created by Quinton Brown 4-24-2020
#Version 3.0

###Variables###

DATE=`date +%m-%d-%y-%H-%M`	#Convinent way to store the current date
STORAGE=/dirBackups		#where the backups will go
LOGS=/var/log/dirBackups.log	#Log location

###End Variables###

###Functions###

#Take current md5sum of the directory

function compare
{
find $dir -type f -exec md5sum {} \; | sort -k 2 | md5sum | cut -b1-33 > /tmp/$dir.md5compare 
}

#Main backup function
function backup
{
tar -j -cf $dir.Backup.$DATE.tar.bz2 $dir 2>> $LOGS
if [ $? -ge 1 ]; then
	echo "$dir Backup failed at $(date)" >> $LOGS
#	echo "$dir Backup failed at $(date) check logs" | mailx -s "Backups Failed" $email
else
	echo "$dir Backup success at $(date)" >> $LOGS
	cat /tmp/$dir.md5compare > /tmp/$dir.currentmd5
	mv $dir.Backup*.tar.bz2 $STORAGE
fi
}

#Check last md5sum with current md5sum

function comparemd5sum 
{
compare
diff -q /tmp/$dir.md5compare /tmp/$dir.currentmd5 > /dev/null 2>&1
if [ $? -ge 1 ]; then
	echo "$dir md5sum differs, running backup and zipping files" >> $LOGS
	backup		#Directory contents has changed, do a backup.
else
	echo "No changes to $dir , not running a backup. $(date)" >> $LOGS	#Nothing has changed. Don't do a backup and log why not.
fi
}

###End Functions###

###Flags###

dir=''
email=''
verbose='false'

print_usage() {
  printf "\nUsage: -d <Directory> -e <EmailAddress> -v=verbose\n The script can hanle one directory path at time. To backup more than one directory at a time, please run the script with multiple instances."
}

while getopts 'd:e:v' flag; do
	case "${flag}" in
	d) dir="${OPTARG}" ;;
	e) email="${OPTARG}";;
	v) verbose='true' ;;
	*) print_usage
	   exit 1 ;;
	esac
done


###End Flags###

#Check if md5tmp is blank first, then execute functions accordingly.

if [ -s /tmp/$dir.currentmd5 ]; then
	echo "Comparing $dir md5sums and determining if backups are nessisary." >> $LOGS #file is not blank, move on to checking last md5sum.
	comparemd5sum 
else
	#file is blank, this is the first time running, move on to main backup function.
	echo "Ran first time setup and $dir backup at $(date)" >> $LOGS
	if [ -s /dirBackups ]; then
		echo "dirBackups already created, skipping creation and moving on with backup of $dir on $(date)" >> $LOGS
		compare
		backup
	else
		echo "Creating dirBackups directory for the first time on $(date)" >> $LOGS
		mkdir $STORAGE
		compare
		backup
	fi	
fi
