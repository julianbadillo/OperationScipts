#!/usr/bin/sh
#  Aborts and clone a given request.
#  And assigns the clone to the location of the original
#  request. Should be used only on requests that are running
#  and have input.

wf=$1

#Abort and clone
echo "python WmAgentScripts/abortAndClone.py $wf"
out="$(python WmAgentScripts/abortAndClone.py $wf)"
#out="$(cat out.txt)"
echo "${out}"

#get the name of the clone from the output
clone=`echo "${out}"| grep 'Cloned workflow:' | awk '{print $3}'`

#get the input location
echo "python getInputLocation.py -c $clone"
out="$(python getInputLocation.py -c $clone)"
echo "${out}"
location=`echo "${out}" | grep -A2 'subscriptions:' | tail -1`

#assign
echo "python WmAgentScripts/assignWorkflow.py -t production -s $location $clone"
out="$(python WmAgentScripts/assignWorkflow.py -t production -s $location $clone)"  
echo $out
