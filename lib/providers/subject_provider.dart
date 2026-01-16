import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/subject_repository.dart';
import '../models/subject.dart';
import 'auth_provider.dart';

final filteredSubjectsProvider = FutureProvider<List<Subject>>((ref) async {
  final repo = ref.watch(subjectRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  
  final allSubjects = await repo.getSubjects();

  // If no user is logged in, show nothing or all (safety check)
  if (user == null) return [];

  // Filter based on the Tunisian Bac Section (Math, Science, etc.)
  return allSubjects.where((s) => s.targetSections.contains(user.section)).toList();
});