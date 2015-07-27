#!/usr/bin/sh
# Makes an ACDC of a small workflow with input
#
wf=$1
task=$2 #StepOneProc

#Abort and clone
echo "python WmAgentScripts/makeACDC.py $wf $task"
out="$(python WmAgentScripts/makeACDC.py $wf $task)"
#out="$(cat out.txt)"
echo "${out}"

#get the name of the ACDC from the output
acdc=`echo "${out}"| grep -A1 'Created:' | tail -1`

#get the input location
echo "python getInputLocation.py -c $wf"
out="$(python getInputLocation.py -c $wf)"
echo "${out}"
location=`echo "${out}" | grep -A2 'subscriptions:' | tail -1`

#assign
echo "python WmAgentScripts/assignWorkflow.py -t production -s $location $acdc"
out="$(python WmAgentScripts/assignWorkflow.py -t production -s $location $acdc)"  
echo $out
