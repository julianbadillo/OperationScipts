#
# Gets the Input location of a given workflow, list
# of workflows or dataset. Useful for discarding stuck 
# workflows due to unsubscribed or unstaged data.
# Author: Julian Badillo
# before using: - Load WmAgentScripts
#               - create your voms proxy
# Usage: python getInputLocation.py [WFNAME | -f FILE | -d DATASET]
#

import WmAgentScripts.reqMgrClient as reqMgrClient
import WmAgentScripts.phedexClient as phedexClient
import WmAgentScripts.dbs3Client as dbsClient
import sys

def formatSize(size):
    """
    To human-readable format
    """
    if size >= 10**12:
        return "%.2f"%(float(size)/10**12)+"T"
    if size >= 10**9:
        return "%.2f"%(float(size)/10**9)+"G"
    if size >= 10**6:
        return "%.2f"%(float(size)/10**12)+"M"
    if size >= 10**3:
        return "%.2f"%(float(size)/10**12)+"K"
    return str(size)+" Bytes"


def main():
    url = 'cmsweb.cern.ch'

    #if dataset given
    if sys.argv[1] == '-d':
        ds = sys.argv[2]
        sites = sorted(phedexClient.getBlockReplicaSites(ds,True))
        print ds
        print "block replicas (only complete):"
        print ', '.join(sites)
        sites = sorted(phedexClient.getSubscriptionSites(ds))
        print "subscriptions:"
        print ', '.join(sites)
        size = dbsClient.getDatasetSize(ds)
        print formatSize(size)
    else:
        # if file given
        if sys.argv[1] == '-f':
            wfs = [l.strip() for l in open(sys.argv[2]) if l.strip()]
        # if single workflow
        else:
            wfs = [argv[1]]

        for wf in wfs:
            print wf
            ds = reqMgrClient.getInputDataSet(url, wf)                
            sites = sorted(phedexClient.getBlockReplicaSites(ds,True))
            print ds
            print "block replicas (only complete):"
            print ', '.join(sites)
            sites = sorted(phedexClient.getSubscriptionSites(ds))
            print "subscriptions:"
            print ', '.join(sites)
            size = dbsClient.getDatasetSize(ds)
            print formatSize(size)

if __name__ == '__main__':
    main()
