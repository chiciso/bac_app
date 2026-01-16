import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // Navigation shortcuts
  void push(Widget page) => Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  void pop() => Navigator.of(this).pop();

  // Screen size shortcuts
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Theme shortcuts
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}