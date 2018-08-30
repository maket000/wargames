standard_freqs = [0.08167,
                  0.01492,
                  0.02782,
                  0.04253,
                  0.12702,
                  0.02228,
                  0.02015,
                  0.06094,
                  0.06966,
                  0.00153,
                  0.00772,
                  0.04025,
                  0.02406,
                  0.06749,
                  0.07507,
                  0.01929,
                  0.00095,
                  0.05987,
                  0.06327,
                  0.09056,
                  0.02758,
                  0.00978,
                  0.02360,
                  0.00150,
                  0.01974,
                  0.00074]

def SS(vec1, vec2):
    return sum([(vec1[x] - vec2[x])**2 for x in range(len(vec1))])

def int2base(x, base):
    if x < 0:
        sign = -1
    elif x == 0:
        return "0"
    else:
        sign = 1
    x *= sign
    
    digits = []
    while x:
        digits.append(str(x % base))
        x = int(x / base)
    if sign < 0:
        digits.append('-')
    digits.reverse()
    return ''.join(digits)

ascii_offset = ord("A")

with open("krypton5.data.1") as f:
    ciphertext = [ord(x) - ascii_offset for x in f.read().replace(" ", "").strip()]
    
dict_size = len(standard_freqs)
ciphertext_length = len(ciphertext)

# Finding key_length

print("""C.I. values
===========""")
for test_length in range(1, 21):
    total = 0
    for seq in range(test_length):
        counts = [0] * dict_size
        for x in range(test_length, ciphertext_length, test_length):
            counts[ciphertext[x]] += 1
        N = len(range(test_length, ciphertext_length, test_length))
        total += sum([counts[x]*(counts[x]-1) for x in range(dict_size)]) / (N*(N-1))
    ci = total / test_length
    print(str(test_length).rjust(2,'0'), str(ci)[:7].ljust(7, '0'), "|"*int(500*ci))

print()
key_length = int(input("Choose a key length: "))
keydeviations = []

for key_position in range(key_length):
    counts = [0 for _ in range(dict_size)]
    for x in range(key_position, ciphertext_length, key_length):
        counts[ciphertext[x]] += 1
    counts_total = sum(counts)
    counts = [x / counts_total for x in counts]

    deviationsum = []
    for letter in range(dict_size):
        y = counts[letter:] + counts[:letter]
        y_bar = sum(y) / dict_size
        y_bar_vec = [y_bar for _ in range(dict_size)]
        ss_tot = SS(y, y_bar_vec)
        ss_reg = SS(standard_freqs, y_bar_vec)
        ss_res = SS(y, standard_freqs)
        r2 = 1 - (ss_res / ss_tot)
        deviationsum.append((letter, r2))

    keydeviations.append(sorted(deviationsum, key=lambda tup: -tup[1]))

for letter in keydeviations:
    print(" ".join([chr(x[0] + ascii_offset) for x in letter]))

permute_depth = 2
    
for keydec in range(permute_depth ** key_length):
    keynum = int2base(keydec, permute_depth).rjust(key_length, '0')
    key = [keydeviations[x][int(keynum[x])][0] for x in range(key_length)]
    decrypted = ""
    for x in range(ciphertext_length):
        decrypted += chr((ciphertext[x] - key[x % key_length]) % dict_size + ascii_offset)
    if "THE" in decrypted:
        print("".join([chr(x + ascii_offset) for x in key]), decrypted)
        a = input("Press return to continue, enter any value to stop. ")
        if a:
            break
        print()
