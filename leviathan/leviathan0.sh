#!/usr/bin/env bash

sshpass -p leviathan0 ssh leviathan0@leviathan.labs.overthewire.org -p 2223

cat .backup/bookmarks.html | grep password
