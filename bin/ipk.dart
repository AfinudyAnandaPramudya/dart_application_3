import 'dart:io';

void main() {
  // Input validation for number of semesters
  int numSemesters;
  while (true) {
    stdout.write('Masukkan jumlah semester: ');
    numSemesters = int.parse(stdin.readLineSync()!);
    if (numSemesters >= 2 && numSemesters <= 14) break;
    print('Jumlah semester harus antara 2 dan 14. Silakan coba lagi.');
  }

  // Initialize lists to store semester data
  List<Semester> semesters = [];

  // Loop through each semester
  for (int i = 0; i < numSemesters; i++) {
    Semester semester = Semester();

    // Input validation for number of courses
    int numCourses;
    while (true) {
      stdout.write('Masukkan jumlah mata kuliah semester ${i + 1}: ');
      numCourses = int.parse(stdin.readLineSync()!);
      if (numCourses >= 2) break;
      print('Jumlah mata kuliah harus minimal 2. Silakan coba lagi.');
    }

    // Loop through each course
    for (int j = 0; j < numCourses; j++) {
      Course course = Course();

      stdout.write('Masukkan nama matkul: ');
      course.name = stdin.readLineSync()!;

      stdout.write('Masukkan jumlah sks matkul: ');
      course.sks = int.parse(stdin.readLineSync()!);

      stdout.write('Masukkan nilai matkul (A/B/C/D/E): ');
      course.grade = stdin.readLineSync()!.toUpperCase();

      // Input validation for grade
      while (!['A', 'B', 'C', 'D', 'E'].contains(course.grade)) {
        print('Nilai huruf harus A, B, C, D, atau E. Silakan coba lagi.');
        stdout.write('Masukkan nilai matkul (A/B/C/D/E): ');
        course.grade = stdin.readLineSync()!.toUpperCase();
      }

      semester.courses.add(course);
    }

    semesters.add(semester);
  }

  // Calculate NR and IPK
  double totalSks = 0;
  double totalGradePoints = 0;
  for (Semester semester in semesters) {
    double semesterSks = 0;
    double semesterGradePoints = 0;
    for (Course course in semester.courses) {
      semesterSks += course.sks;
      semesterGradePoints += getGradePoint(course.grade) * course.sks;
    }
    totalSks += semesterSks;
    totalGradePoints += semesterGradePoints;
    semester.nr = semesterGradePoints / semesterSks;
  }
  double ipk = totalGradePoints / totalSks;

  // Print transcript
  print('==============================================');
  print(' Transkrip Nilai');
  print('==============================================');
  for (int i = 0; i < semesters.length; i++) {
    Semester semester = semesters[i];
    print('Hasil Semester ${i + 1}:');
    for (Course course in semester.courses) {
      print('${course.name} ${course.sks} ${course.grade}');
    }
    print('SKS : ${semester.courses.fold(0, (sum, course) => sum + course.sks)}');
    print('NR : ${semester.nr.toStringAsFixed(2)}');
    print('--------------------------------------------');
  }
  print('Total SKS : ${totalSks.toInt()}');
  print('IPK : ${ipk.toStringAsFixed(2)}');
  print('==============================================');
}

class Semester {
  List<Course> courses = [];
  double nr = 0.0;
}

class Course {
  String name = '';
  int sks = 0;
  String grade = '';
}

double getGradePoint(String grade) {
  switch (grade) {
    case 'A':
      return 4.0;
    case 'B':
      return 3.0;
    case 'C':
      return 2.0;
    case 'D':
      return 1.0;
    case 'E':
      return 0.0;
    default:
      return 0.0;
  }
}