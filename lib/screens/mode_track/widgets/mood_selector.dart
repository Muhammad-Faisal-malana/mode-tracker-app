import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/mood_entry.dart';
import '../../../providers/mood_provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/app_toast.dart';
import 'mood_face.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'How are you feeling?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSizes.p24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _MoodOption(type: MoodType.happy, label: 'Happy'),
              _MoodOption(type: MoodType.neutral, label: 'Neutral'),
              _MoodOption(type: MoodType.sad, label: 'Sad'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodOption extends StatelessWidget {
  final MoodType type;
  final String label;

  const _MoodOption({
    required this.type,
    required this.label,
  });

  void _logMood(BuildContext context) {
    context.read<MoodProvider>().addMood(type);
    AppToast.show(context, 'You are feeling $label!');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoodProvider>();
    final isHovered = provider.hoveredMoodType == type;

    return MouseRegion(
      onEnter: (_) => context.read<MoodProvider>().setHoveredMood(type),
      onExit: (_) => context.read<MoodProvider>().setHoveredMood(null),
      child: InkWell(
        onTap: () => _logMood(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
          child: Column(
            children: [
              MoodFace(type: type, size: 70)
                  .animate(target: isHovered ? 1 : 0)
                  .shimmer(duration: 400.ms, curve: Curves.easeInOut),
              const SizedBox(height: AppSizes.p12),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
                  color: isHovered ? AppColors.textPrimary : AppColors.textQuaternary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
