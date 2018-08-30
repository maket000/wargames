#!/usr/bin/env bash

sshpass -p ROTTEN ssh krypton2@krypton.labs.overthewire.org -p 2222

mkdir /tmp/$$
cd /tmp/$$
cp /krypton/krypton1/* .
ln -s /krypton/krypton1/keyfile.dat
./encrypt krypton3

#find how far the cipher shifts (12 forward in this case)
cat krypton3
cat ciphertext

#write the appropritate tr
cat krypton3 | tr "O-ZA-N" "C-ZA-B"
