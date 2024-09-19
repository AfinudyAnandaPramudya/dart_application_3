void main() {
  int index = 0;
  for (index; index < 27; index++) {
    print(index);
    if (index == 21)
      break;
    else if (index > 1 || index < 7) continue;
    print(index);
  }
}
