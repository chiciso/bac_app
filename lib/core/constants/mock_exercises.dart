import '../../models/exercise.dart';

class MockExercises {
  static List<Exercise> data = [
    // CRITICAL: subjectId must match the TITLE or ID in mock_data.dart
    Exercise(
      id: 'ex1',
      subjectId: 'Mathématiques', // Make sure this matches Subject.title or Subject.id
      year: 2024,
      session: SessionType.principale,
      type: DocumentType.exam,
      pdfUrl: 'https://example.com/math2024.pdf',
    ),
    Exercise(
      id: 'ex2',
      subjectId: 'Physique-Chimie', 
      year: 2024,
      session: SessionType.principale,
      type: DocumentType.exam,
      pdfUrl: 'https://example.com/phys2024.pdf',
    ),
  ];
}