import 'package:flutter/material.dart';

enum MoodType { happy, neutral, sad }

class MoodEntry {
  final String id;
  final DateTime date;
  final MoodType type;
  final Color color;

  MoodEntry({
    required this.id,
    required this.date,
    required this.type,
    required this.color,
  });
}
