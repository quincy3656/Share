#!/bin/bash
#Backup a directory if there is a difference from the last backup.
#You can edit the variables as needed, other than that the script takes care of the rest! This is best pared with a cron entry or cronjob.
#Created by Quinton Brown 4-24-2020

###Variables###
DATE=`date +%m-%d-%y-%H-%M`	#Convinent way to store the current date
DIRECTORY=/home			#what directory to backup
STORAGE=/backups		#where the backups will go
LOGS=/var/log/backups.log	#Log location
EMAIL=email@emaildomain.com	#Email for backupfailures, commented out by default.
MD5TMP=/tmp/backupmd5sum.txt	#stored md5sum for comparisons
MD5COMPARE=/tmp/backupsmd5sumcomp.txt #Current md5sum of directory being backed up.
###End Variables###

###Functions###
#Take current md5sum of the directory
function compare1
{
find $DIRECTORY -type f -exec md5sum {} \; | sort -k 2 | md5sum | cut -b1-33 > $MD5COMPARE 
}

#Main backup function
function backup
{
tar -j -cf homeBackup.$DATE.tar.bz2 $DIRECTORY 2>> $LOGS
if [ $? -ge 1 ]; then
	echo "Backups failed at $(date)" >> $LOGS
#	ehco "Backups failed, check logs"
#	echo "Backups failed at $(date) check logs" | mailx -s "Backups Failed" $EMAIL
else
	echo "Backup success at $(date)" >> $LOGS
#	echo "Backups successful."
	cat $MD5COMPARE > $MD5TMP
	mv homeBackup*.tar.bz2 $STORAGE
fi
}

#Check last md5sum with current md5sum
function comparemd5sum 
{
compare1
diff -q $MD5COMPARE $MD5TMP > /dev/null 2>&1
if [ $? -ge 1 ]; then
	echo "md5sum differs, running backup and zipping files" >> $LOGS
	backup		#Directory contents has changed, do a backup.
else
	echo "No changes to $DIRECTORY , not running a backup. $(date)" >> $LOGS	#Nothing has changed. Don't do a backup and log why not.
#	echo "No changes, not running backups"
fi
}

###End Functions###

#Check if md5tmp is blank first, then execute functions accordingly.

if [ -s /tmp/backupmd5sum.txt ]; then
	echo "Comparing md5sums and determining if backups are nessisary." >> $LOGS #file is not blank, move on to checking last md5sum.
	comparemd5sum 
else
	#file is blank, this is the first time running, move on to main backup function.
	echo "Ran first time setup and backup at $(date)" >> $LOGS
	mkdir $STORAGE
	compare1
	backup
fi

