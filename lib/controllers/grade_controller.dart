import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/grade.dart';

class GradeController {
  final String baseUrl = "http://10.0.2.2:8080/api/grades";

  Future<List<Grade>> getAll() async {
    final res = await http.get(Uri.parse(baseUrl));

    List data = jsonDecode(res.body);
    return data.map((e) => Grade.fromJson(e)).toList();
  }

  Future<void> insert(Grade g) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(g.toJson()),
    );
  }

  Future<void> update(int id, Grade g) async {
    await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(g.toJson()),
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }
}