#!/usr/bin/env bash

sshpass -p UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR ssh bandit9@bandit.labs.overthewire.org -p 2220
strings data.txt | grep "===="

