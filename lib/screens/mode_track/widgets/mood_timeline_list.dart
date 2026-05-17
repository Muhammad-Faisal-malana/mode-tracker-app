import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../providers/mood_provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import 'timeline_entry_card.dart';

class MoodTimelineList extends StatelessWidget {
  const MoodTimelineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, provider, child) {
        if (provider.entries.isEmpty) {
          return Center(
            child: Text(
              'No moods logged yet. Tap a face above to start!',
              style: TextStyle(color: AppColors.textMuted, fontSize: 16),
            ).animate().fadeIn(duration: 800.ms),
          );
        }

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Moods',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSizes.p16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 800;

                  if (isMobile) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: AppSizes.p16,
                        mainAxisSpacing: AppSizes.p16,
                      ),
                      itemCount: provider.entries.length,
                      itemBuilder: (context, index) {
                        final entry = provider.entries[index];
                        return TimelineEntryCard(entry: entry)
                            .animate()
                            .fadeIn(duration: 400.ms, delay: (50 * index).ms)
                            .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutQuad);
                      },
                    );
                  }

                  return SizedBox(
                    height: 220, 
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.entries.length,
                      separatorBuilder: (context, index) => const SizedBox(width: AppSizes.p16),
                      itemBuilder: (context, index) {
                        final entry = provider.entries[index];
                        return SizedBox(
                          width: 200,
                          child: TimelineEntryCard(entry: entry),
                        )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: (50 * index).ms)
                            .slideX(
                              begin: 0.1,
                              end: 0,
                              duration: 400.ms,
                              curve: Curves.easeOutQuad,
                            );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
