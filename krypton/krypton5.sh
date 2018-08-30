#!/usr/bin/env bash

sshpass -p CLEARTEXT ssh krypton5@krypton.labs.overthewire.org -p 2222

cd /krypton/krypton5

# We'll modify our python script to include key-guessing, thanks Charles Babbage

# We get the keys as KEYLENGTH, clever
# and the password we get is RANDOM, I love these passwords
