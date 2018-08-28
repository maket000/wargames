#!/usr/bin/env bash

sshpass -p 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu ssh bandit12@bandit.labs.overthewire.org -p 2220

xxd data.txt -r > a.gz
gzip -d a.gz > b # needs .gz
bzip -d b > c
tar xvf c
