import '../../core/constants/mock_exercises.dart';
import '../../models/exercise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseRepository {
  // Fetch all exercises for a specific subject
  Future<List<Exercise>> getExercisesBySubject(String subjectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockExercises.data.where((e) => e.subjectId == subjectId).toList();
  }
}

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) => ExerciseRepository());