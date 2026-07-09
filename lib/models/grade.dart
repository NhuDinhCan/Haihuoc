class Grade {
  int? id;
  String studentCode;
  String studentName;
  String className;
  String subject;
  double score;
  int semester;
  String schoolYear;

  Grade({
    this.id,
    required this.studentCode,
    required this.studentName,
    required this.className,
    required this.subject,
    required this.score,
    required this.semester,
    required this.schoolYear,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      studentCode: json['studentCode'],
      studentName: json['studentName'],
      className: json['className'],
      subject: json['subject'],

      score: (json['score'] as num).toDouble(),
      semester: (json['semester'] as num).toInt(),

      schoolYear: json['schoolYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studentCode": studentCode,
      "studentName": studentName,
      "className": className,
      "subject": subject,
      "score": score,
      "semester": semester,
      "schoolYear": schoolYear,
    };
  }
}