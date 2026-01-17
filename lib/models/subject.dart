import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String title;
  final String imageUrl;
  final Color color;
  final List<String> targetSections;
  final List<int> availableYears;
  final List<String> sessions;

  Subject({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.targetSections,
    required this.availableYears,
    this.sessions = const ["Principale", "Contrôle"],
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Sans titre',
      imageUrl: json['image_url'] as String? ?? 'https://via.placeholder.com/400',
      color: _parseColor(json['color']),
      targetSections: (json['target_sections'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? 
          [],
      availableYears: (json['available_years'] as List<dynamic>?)
              ?.map((e) => int.tryParse(e.toString()) ?? 0)
              .toList() ?? 
          [],
      sessions: (json['sessions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ?? 
          ["Principale", "Contrôle"],
    );
  }

  static Color _parseColor(dynamic colorData) {
    if (colorData == null) return Colors.blue;
    String hexColor = colorData.toString().toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  Subject copyWith({
    String? id,
    String? title,
    String? imageUrl,
    Color? color,
    List<String>? targetSections,
    List<int>? availableYears,
    List<String>? sessions,
  }) {
    return Subject(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      targetSections: targetSections ?? this.targetSections,
      availableYears: availableYears ?? this.availableYears,
      sessions: sessions ?? this.sessions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'color': '#${color.value.toRadixString(16).substring(2)}',
      'target_sections': targetSections,
      'available_years': availableYears,
      'sessions': sessions,
    };
  }
}