#!/usr/bin/env bash

sshpass -p cvX2JJa4CFALtqS87jk27qwqGhBM9plV ssh bandit8@bandit.labs.overthewire.org -p 2220
sort data.txt | uniq -u

