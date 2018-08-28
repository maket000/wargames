#!/usr/bin/env bash

sshpass -p IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR ssh bandit11@bandit.labs.overthewire.org -p 2220
cat data.txt | tr "A-Za-z" "N-ZA-Mn-za-m"

