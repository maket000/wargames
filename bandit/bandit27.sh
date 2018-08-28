#!/usr/bin/env bash

sshpass -p 3ba3118a22e93127a4ed485be72ef5ea ssh bandit27@bandit.labs.overthewire.org -p 2220
mkdir /tmp/$$
cd /tmp/$$
git clone ssh://bandit27-git@localhost/home/bandit27-git/repo
cat repo/README
