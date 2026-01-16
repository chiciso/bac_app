import 'package:flutter/material.dart';
import '../../models/subject.dart';
import 'bac_sections.dart';

class MockData {
  static final List<Subject> subjects = [
    // 1. MATH: Available for everyone, but exams differ by section
    Subject(
      id: "math",
      title: "Mathématiques",
      color: Colors.blueAccent,
      targetSections: BacSections.all,
      availableYears: List.generate(15, (index) => 2010 + index), // 2010-2024
      imageUrl: "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?q=80&w=1000",
    ),

    // 2. PHYSICS: Not for Economy
    Subject(
      id: "physic",
      title: "Physique-Chimie",
      color: Colors.deepPurple,
      targetSections: [
        BacSections.science,
        BacSections.math,
        BacSections.tech,
        BacSections.info
      ],
      availableYears: List.generate(15, (index) => 2010 + index),
      imageUrl: "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=1000",
    ),

    // 3. STI (Technique Only)
    Subject(
      id: "tech",
      title: "Technologie",
      color: Colors.orange,
      targetSections: [BacSections.tech],
      availableYears: List.generate(15, (index) => 2010 + index),
      imageUrl: "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=1000",
    ),

    // 4. ALGO (Info Only)
    Subject(
      id: "algo",
      title: "Algorithmique",
      color: Colors.teal,
      targetSections: [BacSections.info],
      availableYears: List.generate(15, (index) => 2010 + index),
      imageUrl: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=1000",
    ),

    // 5. ECONOMY (Eco Only)
    Subject(
      id: "eco",
      title: "Économie",
      color: Colors.green,
      targetSections: [BacSections.economy],
      availableYears: List.generate(15, (index) => 2010 + index),
      imageUrl: "https://images.unsplash.com/photo-1611974714851-48206139d733?q=80&w=1000",
    ),
  ];
}