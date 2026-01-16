import '../../models/exercise.dart';

class MockExercises {
  static List<Exercise> data = [
    Exercise(
      id: 'ex_001',
      subjectId: 'physique', // Matches the ID in mock_data.dart
      year: 2024,
      session: SessionType.principale,
      type: DocumentType.exam,
      pdfUrl: 'https://www.bac.org.tn/physique/2024/principale.pdf',
    ),
    Exercise(
      id: 'ex_002',
      subjectId: 'physique',
      year: 2024,
      session: SessionType.principale,
      type: DocumentType.correction,
      pdfUrl: 'https://www.bac.org.tn/physique/2024/principale_corr.pdf',
    ),
    // ... add more years and sessions here
  ];
}