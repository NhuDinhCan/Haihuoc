import 'package:flutter/material.dart';
import '../controllers/grade_controller.dart';
import '../models/grade.dart';

class EditGradeScreen extends StatefulWidget {
  final Grade grade;

  EditGradeScreen({required this.grade});

  @override
  State<EditGradeScreen> createState() => _EditGradeScreenState();
}

class _EditGradeScreenState extends State<EditGradeScreen> {
  final controller = GradeController();

  late TextEditingController studentName;
  late TextEditingController subject;
  late TextEditingController score;

  @override
  void initState() {
    super.initState();

    studentName = TextEditingController(text: widget.grade.studentName);
    subject = TextEditingController(text: widget.grade.subject);
    score = TextEditingController(text: widget.grade.score.toString());
  }

  void save() async {
    await controller.update(
      widget.grade.id!,
      Grade(
        studentCode: widget.grade.studentCode,
        studentName: studentName.text,
        className: widget.grade.className,
        subject: subject.text,
        score: double.tryParse(score.text) ?? 0,
        semester: widget.grade.semester,
        schoolYear: widget.grade.schoolYear,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Grade")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: studentName,
              decoration: InputDecoration(labelText: "Student Name"),
            ),
            TextField(
              controller: subject,
              decoration: InputDecoration(labelText: "Subject"),
            ),
            TextField(
              controller: score,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Score"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}