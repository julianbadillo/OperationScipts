#!/bin/bash
# Generates some plots for the CompOps meeting
# Author: Julian Badillo
# before running:   - fill the weekly agent crash file (agent.log)
#                   - run the getData script on issues to get data.json

#running and pending for the production team
curl "http://dashb-cms-prod.cern.ch/dashboard/request.py/condorjobnumbers_individual?sites=cmsgwms-submit1.fnal.gov&sites=cmsgwms-submit2.fnal.gov&sites=cmssrv217.fnal.gov&sites=cmssrv218.fnal.gov&sites=cmssrv219.fnal.gov&sitesSort=11&jobTypes=&start=null&end=null&timeRange=lastWeek&granularity=Hourly&cores=&sortBy=4&series=All&type=r" > ~/www/plots/production_running.png
curl "http://dashb-cms-prod.cern.ch/dashboard/request.py/condorjobnumbers_individual?sites=cmsgwms-submit1.fnal.gov&sites=cmsgwms-submit2.fnal.gov&sites=cmssrv217.fnal.gov&sites=cmssrv218.fnal.gov&sites=cmssrv219.fnal.gov&sitesSort=11&jobTypes=&start=null&end=null&timeRange=lastWeek&granularity=Hourly&cores=&sortBy=4&series=All&type=p" > ~/www/plots/production_pending.png
#running and pending for the reproc/mc team
curl "http://dashb-cms-prod.cern.ch/dashboard/request.py/condorjobnumbers_individual?sites=vocms201.cern.ch&sites=vocms202.cern.ch&sites=vocms216.cern.ch&sites=vocms234.cern.ch&sites=vocms235.cern.ch&sites=vocms237.cern.ch&sitesSort=11&jobTypes=&start=null&end=null&timeRange=lastWeek&granularity=Hourly&cores=&sortBy=4&series=All&type=r" > ~/www/plots/reproc_mc_running.png
curl "http://dashb-cms-prod.cern.ch/dashboard/request.py/condorjobnumbers_individual?sites=vocms201.cern.ch&sites=vocms202.cern.ch&sites=vocms216.cern.ch&sites=vocms234.cern.ch&sites=vocms235.cern.ch&sites=vocms237.cern.ch&sitesSort=11&jobTypes=&start=null&end=null&timeRange=lastWeek&granularity=Hourly&cores=&sortBy=4&series=All&type=p" > ~/www/plots/reproc_mc_pending.png

#generate age distribution for status, type and campaign
python WmAgentScripts/issues/plotAgeDistribution.py ~/www/data.json -j

#generate plots for Component crash
lastdate=`tail -1 agent.log | awk '{print $1}'`
echo $lastdate
awk "/$lastdate/ {print}" agent.log > agent_temp.log
python WmAgentScripts/issues/plotComponentCrash.py agent_temp.log 
