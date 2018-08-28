#!/usr/bin/env bash

sshpass -p 47e603bb428404d265f59c42920d81e5 ssh bandit31@bandit.labs.overthewire.org -p 2220
mkdir /tmp/$$
cd /tmp/$$
git clone ssh://bandit31-git@localhost/home/bandit31-git/repo
cd repo
echo "May I come in?" > key.txt
git add key.txt -f
git push -u origin
