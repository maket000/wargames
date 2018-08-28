#!/usr/bin/env bash

sshpass -p 5b90576bedb2cc04c86a9e924ce42faf ssh bandit30@bandit.labs.overthewire.org -p 2220
mkdir /tmp/$$
cd /tmp/$$
git clone ssh://bandit30-git@localhost/home/bandit30-git/repo
cd repo
git show
