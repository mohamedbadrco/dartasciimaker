int rtog(int hexa) {
  int r = hexa & 0xff;
  int g = (hexa >> 8) & 0xff;
  int b = (hexa >> 16) & 0xff;
  return 0x00000000 | b | g << 8 | r << 16;
}
