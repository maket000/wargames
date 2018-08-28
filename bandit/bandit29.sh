#!/usr/bin/env bash

sshpass -p bbc96594b4e001778eee9975372716b2 ssh bandit29@bandit.labs.overthewire.org -p 2220
mkdir /tmp/$$
cd /tmp/$$
git clone ssh://bandit29-git@localhost/home/bandit29-git/repo
cd repo
git checkout dev
cat README
