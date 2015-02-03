#!/bin/sh
# Connects to a list of agents calling the force-complete procedure described
# here:
# https://twiki.cern.ch/twiki/bin/view/CMSPublic/CompOpsWorkflowOperatorResponsiblities#Force_Complete_WorkFlows
# author: Julian Badillo
# before running: load your kerberos credentials
# Usage: sh force_complete.sh WFNAME
# 

#workflow name
wf=$1

#list of agents
fnal_agents="cmssrv217.fnal.gov cmssrv218.fnal.gov cmssrv219.fnal.gov cmsgwms-submit1.fnal.gov cmsgwms-submit2.fnal.gov"
#cern_agents="vocms0308 vocms0309 vocms0310"
cern_agents=""

#generate command for CERN agents
fc="workqueue.doneWork(WorkflowName='$wf');exit();"
com="sudo -u cmst1 /bin/bash --init-file ~cmst1/.bashrc
agentenv
echo \"$fc\" | \$manage execute-agent wmagent-workqueue -i
exit
exit"

for a in $cern_agents
do
    #send to agents
    echo "$com" | ssh $a -tt
done

#generate command for FNAL agents
com="source /data/admin/wmagent/env.sh
echo \"$fc\" | \$manage execute-agent wmagent-workqueue -i
exit"

for a in $fnal_agents
do
    #send to agents
    echo "$com" | ssh $a -tt
done
