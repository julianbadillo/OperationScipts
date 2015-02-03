#!/usr/bin/env python
# Quickly gets the status of a given workflow
# Use this if you want to avoid using WMStats :)
# Author: Julian Badillo
# before using: load your voms proxy
# Usage: python getWorkflowStatus [WFNAME | -f FILE]
# -f FILE: to retrieve the status of several workflows at the same
#           time in a text file
import sys
import json
import urllib2,urllib, httplib, sys, re, os
from xml.dom.minidom import getDOMImplementation

def getStatus(url, workflow):
    conn = httplib.HTTPSConnection(url, cert_file = os.getenv('X509_USER_PROXY'), key_file = os.getenv('X509_USER_PROXY'))
    r1=conn.request('GET','/reqmgr/reqMgr/request?requestName=' + workflow)
    r2=conn.getresponse()
    #data = r2.read()
    s = json.loads(r2.read())
    t = s['RequestStatus']
    return t

def main():
    args=sys.argv[1:]
    url = 'cmsweb.cern.ch'
    if not len(args) < 1:
        print "usage: python getWorkflowStatus.py <text_file_with_the_workflow_names>"
        sys.exit(0)
    if len(args) == 1:
        wfs = args
    else:
        inputFile = args[0]
        f = open(inputFile, 'r')
        wfs = [l.strip() for l in f if l.strip()]

    for line in wfs:
        workflow = line.rstrip('\n')
        print "%s\t%s" %(workflow, getStatus(url, workflow))

if __name__ == "__main__":
    main()
