#!/usr/bin/env bash

sshpass -p vuH0coox6m ssh leviathan4@leviathan.labs.overthewire.org -p 2223

cd .trash
./bin

python
>>> "".join([chr(int(x,2)) for x in "01010100 01101001 01110100 01101000 00110100 01100011 01101111 01101011 01
100101 01101001 00001010".split()])
'Tith4cokei\n'
