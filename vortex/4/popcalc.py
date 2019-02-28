#!/usr/bin/python3

def pc(fstraddr, pfsp):
    bdiff = fstraddr - pfsp
    fcount = bdiff / 8
    predict = bdiff / 5
    predictloc = fstraddr + predict*3
    print("Diff:", bdiff)
    print("Diff/8:", fcount)
    print("predicted:", predict)
    print("predicted dummy/addr pair start location:", hex(int(predictloc)))

if __name__ == "__main__":
    import sys
    assert len(sys.argv) == 3
    pc(eval(sys.argv[1]), eval(sys.argv[2]))
