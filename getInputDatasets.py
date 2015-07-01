#
# To quickly get a list of input datasets (for creating subscriptions)
# Needs WmAgentScripts libraries

import WmAgentScripts.reqMgrClient as reqMgr
import sys, optparse

def main():
    usage = 'python %prog [OPTIONS] [WORKFLOW]'
    parser = optparse.OptionParser(usage = usage)
    parser.add_option('-f', '--file', help='Text file with several workflows',dest='file')
    (options, args) = parser.parse_args()

    url = 'cmsweb.cern.ch'
     
    if options.file:
        wfs = [l.strip() for l in open(options.file) if l.strip()]
    else:
        wfs = [args[0]]
    #Several wfs in one go
    for wf in wfs:
        ds = reqMgr.getInputDataSet(url, wf)
        print wf
        print ds

if __name__ == '__main__':
    main()



