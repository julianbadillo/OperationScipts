#!/bin/bash
# List log files on Castor for a given workflow
# Author: Julian Badillo
# before using: load your voms proxy
# Usage: sh list_logs.sh WFNAME YEAR MONTH
wf=$1
year=$2
month=$3
echo "looking in /eoscms.cern.ch/cms/store/logs/prod/$year/$month/WMAgent/$wf"
eoscms ls /store/logs/prod/$year/$month/WMAgent/$wf
