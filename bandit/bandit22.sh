#!/usr/bin/env bash

sshpass -p Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI ssh bandit22@bandit.labs.overthewire.org -p 2220
cat /tmp/`echo I am user bandit23 | md5sum | cut -d ' ' -f 1`
