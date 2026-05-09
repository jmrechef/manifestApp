import 'package:flutter/material.dart';

class MeditationCategory {
  const MeditationCategory({
    required this.title,
    required this.icon,
    required this.duration,
  });

  final String title;
  final IconData icon;
  final String duration;
}
