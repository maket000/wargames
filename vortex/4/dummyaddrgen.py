#!/usr/bin/python3

WORDLEN = 8

def dapgen(addr):
    target = int(addr.lstrip("0x"), 16)
    print("".join(["____" + "".join(["\\x" + hex(target + i)[2:].rjust(WORDLEN, '0')[j:j+2] for j in range(WORDLEN - 2, -1, -2)]) for i in range(4)]))

if __name__ == "__main__":
    import sys;
    assert(len(sys.argv) == 2)
    dapgen(sys.argv[1])
    
