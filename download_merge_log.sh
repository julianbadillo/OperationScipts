#!/usr/bin/bash
# Download a log with the word "Merge" on the file name
# 

echo "lookin on /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1"
nsls /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1
logf=`nsls /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1 | grep Merge | head -1 `
echo 'retrieving "'$logf'"'
echo
#cmsStage /store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
#rfcp /castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
xrdcp root://castorcms///castor/cern.ch/cms/store/logs/prod/$2/$3/WMAgent/$1/$logf ./public/ &
