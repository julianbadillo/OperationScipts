#
# To quickly get a list of input datasets (for creating subscriptions)
# Needs WmAgentScripts libraries

import WmAgentScripts.reqMgrClient as reqMgr
import sys

def main():
    f = sys.argv[1]
    url = 'cmsweb.cern.ch'
    for wf in open(f):
        ds = reqMgr.getInputDataSet(url, wf)
        print ds

if __name__ == '__main__':
    main()

