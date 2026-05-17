import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/mood_selector.dart';
import 'widgets/mood_timeline_list.dart';
import '../../core/constants/app_sizes.dart';

class ModeTrackWeb extends StatelessWidget {
  const ModeTrackWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p48,
          vertical: AppSizes.p48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.p20),
            const MoodSelector()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOutQuad,
                ),
            const SizedBox(height: AppSizes.p48),
            const MoodTimelineList(),
            const SizedBox(height: AppSizes.p40),
          ],
        ),
      ),
    );
  }
}
