#!/usr/bin/env bash

# Just ROT13

sshpass -p KRYPTONISGREAT ssh krypton1@krypton.labs.overthewire.org -p 2222

cat /krypton/krypton1/krypton2 | tr "A-Za-z" "N-ZA-Mn-za-m"

