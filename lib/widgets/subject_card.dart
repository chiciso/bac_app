import 'package:flutter/material.dart';
import '../models/subject.dart';
import 'app_network_image.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final double progress; // 0.0 to 1.0 (Passed from parent)
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: subject.color.withValues(alpha: 0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // 1. Background Image
              AppNetworkImage(
                imageUrl: subject.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              // 2. Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                  ),
                ),
              ),

              // 3. Progress Ring (Top Right)
              Positioned(
                top: 20,
                right: 20,
                child: _buildProgressRing(),
              ),

              // 4. Content (Bottom)
              Positioned(
                bottom: 25,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.history_edu, color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        const Text(
                          "2010 - 2024",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const Spacer(),
                        const Icon(Icons.stars, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        const Text(
                          "+XP",
                          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressRing() {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(subject.color),
            strokeWidth: 4,
          ),
          Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}