import operator

with open("krypton3.data") as f:
    letters = f.read().strip()

for length in range(1, 4):
    freqs = {}
    for start in range(0, len(letters) - (length - 1)):
        ss = letters[start:start+length]
        if ss not in freqs:
            freqs[ss] = 0
        freqs[ss] += 1
    sorted_freqs = sorted(freqs.items(), key=lambda x: -x[1])

    n_print = 26 // length
    print("Top %d frequencies for length: %d" % (n_print, length))
    print("\n".join([x[0] for x in sorted_freqs[:n_print]]))

