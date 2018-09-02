#!/usr/bin/env bash

sshpass -p Tith4cokei ssh leviathan6@leviathan.labs.overthewire.org -p 2223

for x in `seq -w 9999`;
do
    ./leviathan $x
done

