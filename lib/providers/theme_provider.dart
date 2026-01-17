import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

// This provider stores the current background color. 
// Default is set to a neutral blue.
final backgroundAccentColorProvider = StateProvider<Color>((ref) => const Color(0xFF1565C0));