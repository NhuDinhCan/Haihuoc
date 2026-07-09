import 'package:flutter/material.dart';
import '../controllers/grade_controller.dart';
import '../models/grade.dart';

class AddGradeScreen extends StatefulWidget {
  @override
  State<AddGradeScreen> createState() => _AddGradeScreenState();
}

class _AddGradeScreenState extends State<AddGradeScreen> {
  final controller = GradeController();

  final studentName = TextEditingController();
  final subject = TextEditingController();
  final score = TextEditingController();

  bool isLoading = false;

  void save() async {
    if (studentName.text.isEmpty ||
        subject.text.isEmpty ||
        score.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    setState(() => isLoading = true);

    await controller.insert(
      Grade(
        studentCode: "S01",
        studentName: studentName.text,
        className: "SE1913",
        subject: subject.text,
        score: double.tryParse(score.text) ?? 0,
        semester: 1,
        schoolYear: "2025-2026",
      ),
    );

    setState(() => isLoading = false);

    Navigator.pop(context);
  }

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Grade"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: studentName,
              decoration: inputStyle("Student Name", Icons.person),
            ),
            SizedBox(height: 12),

            TextField(
              controller: subject,
              decoration: inputStyle("Subject", Icons.book),
            ),
            SizedBox(height: 12),

            TextField(
              controller: score,
              keyboardType: TextInputType.number,
              decoration: inputStyle("Score", Icons.star),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : save,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Save Grade"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}