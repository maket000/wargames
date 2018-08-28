#!/usr/bin/env bash

# same vi bullshit as last time

sshpass -p 5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z ssh bandit26@bandit.labs.overthewire.org -p 2220

# spawn a shell
:set shell=/bin/bash
:sh

./bandit27-do cat /etc/bandit_pass/bandit27
