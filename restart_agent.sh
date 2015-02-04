#!/usr/bin/bash
# Connects to a given WMAgent and restarts it
# before running: Load kerberos credentials
# Author: Julian Badillo
# Usage: sh restart_agent.sh AGENT_NAME
# 

agent=$1

#generate command
if [[ "$agent" == *.fnal.gov ]]
then
    com="source /data/admin/wmagent/env.sh
    \$manage stop-agent
    \$manage stop-couch
    sleep 10
    \$manage start-couch
    sleep 20
    \$manage start-agent
    exit"
else
    com="sudo -u cmst1 /bin/bash --init-file ~cmst1/.bashrc
    source /data/admin/wmagent/env.sh
    \$manage stop-agent
    \$manage stop-couch
    sleep 10
    \$manage start-couch
    sleep 20
    \$manage start-agent
    exit
    exit"
fi
#send command to agent
echo "$com" | ssh $agent -tt
