enum SessionType { principale, controle }
enum DocumentType { exam, correction }

class Exercise {
  final String id;
  final String subjectId;      // Link to the parent subject (e.g., 'math_01')
  final int year;              // e.g., 2024
  final SessionType session;   // principale or controle
  final DocumentType type;      // Is this the exam paper or the solution?
  final String pdfUrl;         // The URL to the PDF file
  final int difficulty;        // 1-5 (Optional: for gamification)
  
  Exercise({
    required this.id,
    required this.subjectId,
    required this.year,
    required this.session,
    required this.type,
    required this.pdfUrl,
    this.difficulty = 3,
  });

  // Factory to convert JSON data (from API or Mock) into an Exercise object
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      subjectId: json['subject_id'],
      year: json['year'],
      session: json['session'] == 'principale' 
          ? SessionType.principale 
          : SessionType.controle,
      type: json['type'] == 'correction' 
          ? DocumentType.correction 
          : DocumentType.exam,
      pdfUrl: json['pdf_url'],
      difficulty: json['difficulty'] ?? 3,
    );
  }
}