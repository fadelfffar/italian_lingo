import 'package:flutter/material.dart';

import 'exam_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LingoApp());
}

class LingoApp extends StatefulWidget {
  const LingoApp({super.key});

  @override
  State<LingoApp> createState() => _LingoAppState();
}

class _LingoAppState extends State<LingoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Italian Lingo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ExamScreen(studentName: "Student"),
    );
  }
}
