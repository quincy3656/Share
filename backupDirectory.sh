#!/bin/bash
#Backup the home directory if there is a difference from the last backup.

DATE=`date +%m-%d-%y-%H-%M`	#Convinent way to store the current date
DIRECTORY1=/home		#what directory to backup
STORAGE=/backups		#where the backups will go
LOGS=/var/log/backups.log	#Log location
EMAIL=email@emaildomain.com	#Email alerting too
MD5TMP=/tmp/backupmd5sum.txt	#stored md5sum for comparisons
MD5COMPARE=/tmp/backupsmd5sumcomp.txt #Current md5sum of directory being backed up.


#take current md5sum of /home/
function compare1
{
find $DIRECTORY1 -type f -exec md5sum {} \; | sort -k 2 | md5sum | cut -b1-33 > $MD5COMPARE 
}

#Main backup function
function backup
{
tar -cf homeBackup.$DATE.tar.bz2 $DIRECTORY1 2>> $LOGS
if [ $? -ge 1 ]; then
	echo "Backups failed at $(date) check logs" >> $LOGS
#	echo "Backups failed at $(date)" | mailx -s "Backups Failed" $EMAIL
else
	echo "Backup success at $(date)" >> $LOGS
	cat $MD5COMPARE > $MD5TMP
	mv homeBackup*.tar.bz2 $STORAGE
fi
}

function comparemd5sum 

#check last md5sum with current md5sum
{
compare1
diff -q $MD5COMPARE $MD5TMP > /dev/null 2>&1
if [ $? -ge 1 ]; then
	backup		#Directory contents has changed, do a backup.
else
	echo "No changes to $DIRECTORY1 , not running a backup. $(date)" >> $LOGS	#Nothing has changed. Don't do a backup and log why not.
fi
}

#Check if md5tmp is blank first

if [ -s /tmp/backupmd5sum.txt ]; then
	echo "file is not blank-comparing md5sums" #file is not blank, move on to checking last md5sum.
	comparemd5sum 
else
	echo "file is blank-first time running-running backups"	#file is blank, this is the first time running, move on to main backup function.
	compare1
	backup
fi
