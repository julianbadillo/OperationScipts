
#XRD_CONNECTIONWINDOW
#     A time window for the connection establishment. A connection failure is declared if the connection is
#     not established within the time window. If a connection failure happens earlier then another connection
#     attempt will only be made at the beginning of the next window.

#XRD_CONNECTIONRETRY
#     Number of connection attempts that should be made (number of available connection windows) before
#     declaring a permanent failure.

#XRD_REQUESTTIMEOUT
#     Default value for the time after which an error is declared if it was impossible to get a response to a
#     request.

export XRD_CONNECTIONWINDOW=43200 #12 hours
export XRD_CONNECTIONRETRY=10 #10 retries
export XRD_REQUESTTIMEOUT=129600 #36 hours

wf=$1
year=$2
month=$3
if [ -z "$4" ]
then
    echo "looking in /castor/cern.ch/cms/store/logs/prod/$year/$month/WMAgent/$wf"
    logs=`nsls /castor/cern.ch/cms/store/logs/prod/$year/$month/WMAgent/$wf | grep LogCollect | head -1`
else
    logs=$4
fi
echo "retrieving file $logs"
#cmsStage /store/logs/prod/$year/$month/WMAgent/$w/$logs ./public/ &
xrdcopy "root://castorcms.cern.ch//castor/cern.ch/cms/store/logs/prod/$year/$month/WMAgent/$wf/$logs?svcClass=archive" ./public/ &
