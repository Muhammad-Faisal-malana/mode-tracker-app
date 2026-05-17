import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../models/mood_entry.dart';
import '../../../providers/mood_provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/utils/string_extensions.dart';
import 'mood_face.dart';

class TimelineEntryCard extends StatelessWidget {
  final MoodEntry entry;

  const TimelineEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoodProvider>();
    final isTapped = provider.tappedEntryId == entry.id;

    return InkWell(
      onTap: () => context.read<MoodProvider>().tapEntry(entry.id),
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      splashColor:Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          color: entry.color.withValues(alpha: 0.15),
          border: Border.all(color: entry.color.withValues(alpha: 0.3), width: 2),
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormatters.shortDate(entry.date),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSizes.p4),
            Text(
              DateFormatters.timeOnly(entry.date),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textQuaternary,
              ),
            ),
            const SizedBox(height: AppSizes.p16),
            MoodFace(type: entry.type, size: 60)
                .animate(target: isTapped ? 1 : 0)
                .shake(duration: 400.ms, hz: 4)
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 200.ms)
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 200.ms),
            const SizedBox(height: AppSizes.p16),
            Text(
              entry.type.name.capitalizeFirst(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
