#!/usr/bin/bash
# Connects to a given WMAgent and restarts the
# given component, following this commands:
# https://twiki.cern.ch/twiki/bin/view/CMSPublic/CompOpsWorkflowOperatorResponsiblities#Are_all_components_up
# You have to type the component's name exactly
# (With correct casing)
# before running: Load kerberos credentials
# Author: Julian Badillo
# Usage: sh restart_agent.sh AGENT_NAME COMPONENT_NAME
#

agent=$1
component=$2

#generate command
if [[ "$agent" == *.fnal.gov ]]
then 
    echo "FNAL AGENT"
    com="source /data/admin/wmagent/env.sh
    \$manage execute-agent wmcoreD --shutdown --component $component
    sleep 10
    \$manage execute-agent wmcoreD --start --component $component
    exit
    exit"
else
    echo "CERN AGENT"
    com="sudo -u cmst1 /bin/bash --init-file ~cmst1/.bashrc
    source /data/admin/wmagent/env.sh
    \$manage execute-agent wmcoreD --shutdown --component $component
    sleep 10
    \$manage execute-agent wmcoreD --start --component $component
    exit
    exit"
fi
    
#send command to agent
echo "$com" | ssh $agent -tt
