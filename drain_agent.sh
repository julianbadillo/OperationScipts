#!/bin/sh
# Connects to an agent and sets it in drain mode 
# (doesn't receive more work from Workqueueue), following this steps:
# https://twiki.cern.ch/twiki/bin/view/CMSPublic/CompOpsWorkflowOperatorResponsiblities#Draining_An_Agent
source /data/admin/wmagent/env.sh
$manage stop-agent
sed -i "s/config.WorkQueueManager.queueParams = {\(.*\)}/config.WorkQueueManager.queueParams = {\1, 'DrainMode': True}/" config/wmagent/config.py
sed -i "s/config.ErrorHandler.maxRetries.*/config.ErrorHandler.maxRetries = {'default' : 1, 'Harvesting' : 1, 'Merge' : 1, 'LogCollect' : 0, 'Cleanup' : 2}/" config/wmagent/config.py
$manage start-agentsed -i "s/config.WorkQueueManager.queueParams = {\(.*\)}/config.WorkQueueManager.queueParams = {\1, 'DrainMode': True}/" config/wmagent/config.py
