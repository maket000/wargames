int main(int argc, char **argv)
{
  char buf[58];
  uint32_t hi;
  if((hi = crc32(0, argv[1], strlen(argv[1]))) == 0xe1ca95ee) {
    strcpy(buf, argv[1]);
  } else {
    printf("0x%08x\n", hi);
  }
}
