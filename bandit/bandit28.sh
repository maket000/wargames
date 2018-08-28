#!/usr/bin/env bash

sshpass -p 0ef186ac70e04ea33b4c1853d2526fa2 ssh bandit28@bandit.labs.overthewire.org -p 2220
mkdir /tmp/$$
cd /tmp/$$
git clone ssh://bandit28-git@localhost/home/bandit28-git/repo
cd repo
git checkout 196c3ed
cat README
