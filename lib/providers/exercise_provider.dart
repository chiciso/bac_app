import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/repositories/exercise_repository.dart';
import '../models/exercise.dart';

// Provider that fetches exercises based on the subject currently viewed
final subjectExercisesProvider = FutureProvider.family<List<Exercise>, String>((ref, subjectId) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  return repo.getExercisesBySubject(subjectId);
});

// StateProvider to track the selected session in the DetailPage (Principale vs Contrôle)
final selectedSessionProvider = StateProvider<SessionType>((ref) => SessionType.principale);