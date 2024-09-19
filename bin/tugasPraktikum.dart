void main() {
  String nama = 'Apin';
  String nim = '2241760096';

  for (int i = 0; i <= 201; i++) {
    if (prima(i)) {
      print('$i adalah bilangan prima - $nama ($nim)');
    }
  }
}

bool prima(int number) {
  if (number <= 1) return false;
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}
