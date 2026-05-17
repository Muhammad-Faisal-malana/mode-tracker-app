import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../core/constants/app_colors.dart';

class MoodProvider extends ChangeNotifier {
  List<MoodEntry> _entries = [];
  String? _tappedEntryId;
  MoodType? _hoveredMoodType;

  List<MoodEntry> get entries => List.unmodifiable(_entries);
  String? get tappedEntryId => _tappedEntryId;
  MoodType? get hoveredMoodType => _hoveredMoodType;

  void tapEntry(String id) {
    _tappedEntryId = id;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_tappedEntryId == id) {
        _tappedEntryId = null;
        notifyListeners();
      }
    });
  }

  void setHoveredMood(MoodType? type) {
    _hoveredMoodType = type;
    notifyListeners();
  }

  void addMood(MoodType type) {
    Color moodColor;
    switch (type) {
      case MoodType.happy:
        moodColor = AppColors.happy;
        break;
      case MoodType.neutral:
        moodColor = AppColors.neutral;
        break;
      case MoodType.sad:
        moodColor = AppColors.sad;
        break;
    }

    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      type: type,
      color: moodColor,
    );

    _entries = [entry, ..._entries].take(7).toList();

    notifyListeners();
  }
}
