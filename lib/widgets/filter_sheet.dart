import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import 'app_button.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          AppSpacing.h24,
          const Text(
            "Filter Exercises",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          AppSpacing.h16,
          const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
          AppSpacing.h8,
          Wrap(
            spacing: 8,
            children: [
              _FilterChip(label: "Biology", isSelected: true),
              _FilterChip(label: "Physics"),
              _FilterChip(label: "History"),
              _FilterChip(label: "Math"),
            ],
          ),
          AppSpacing.h24,
          AppButton(
            text: "Apply Filters",
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.black : Colors.grey[100],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
