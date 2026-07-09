import 'package:flutter/material.dart';
import '../controllers/grade_controller.dart';
import '../models/grade.dart';
import 'add_grade_screen.dart';
import 'edit_grade_screen.dart';

class ListGradeScreen extends StatefulWidget {
  @override
  State createState() => _ListGradeScreenState();
}

class _ListGradeScreenState extends State<ListGradeScreen> {
  GradeController controller = GradeController();
  List<Grade> list = [];
  bool isLoading = false;

  load() async {
    setState(() => isLoading = true);
    list = await controller.getAll();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  void deleteGrade(int id) async {
    await controller.delete(id);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Hello SE1913 - Grade"),
        centerTitle: true,
      ),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddGradeScreen()),
            ).then((_) => load());
          },
        ),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : list.isEmpty
          ? Center(child: Text("Chưa có dữ liệu"))
          : RefreshIndicator(
        onRefresh: () async => load(),
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final g = list[i];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditGradeScreen(grade: g),
                    ),
                  ).then((_) => load());
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          g.studentName.isNotEmpty
                              ? g.studentName[0]
                              : "?",
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              g.studentName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${g.subject} • ${g.className}"),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          g.score.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Xóa"),
                              content: Text("Xóa bản ghi này?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context),
                                  child: Text("Hủy"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteGrade(g.id!);
                                  },
                                  child: Text("Xóa"),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}