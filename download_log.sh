#!/usr/bin/bash
# downloads a log file for a given workflow on Castor
# Author: Julian Badillo
# before using: Generate your voms proxy
# Usage: sh download_log WFNAME YEAR MONTH [FILENAME]
# If FILENAME is not specified, the script will download the first
# file in the directory
echo "lookin on /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1"
#list of log files with nsls
logf=`nsls /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1 | grep LogCollect | head -1`
echo 'retrieving "'$logf'"'
echo
#cmsStage /store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
#rfcp /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
#downloading it with xrdcp
xrdcp root://castorcms///castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
