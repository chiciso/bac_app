import 'package:flutter/material.dart';
import '../models/exercise.dart';

class PdfViewerPage extends StatelessWidget {
  final Exercise exercise;

  const PdfViewerPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${exercise.year} - ${exercise.session.name.toUpperCase()}"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              "Opening: ${exercise.type == DocumentType.exam ? 'Exam Paper' : 'Correction'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(exercise.pdfUrl, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text("Loading PDF Viewer..."),
          ],
        ),
      ),
    );
  }
}