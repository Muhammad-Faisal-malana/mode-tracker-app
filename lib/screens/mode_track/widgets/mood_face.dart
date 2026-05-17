import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../models/mood_entry.dart';
import '../../../painters/mood_painter.dart';
import '../../../core/constants/app_colors.dart';

class MoodFace extends StatelessWidget {
  final MoodType type;
  final double size;
  final Color? colorOverride;

  const MoodFace({
    super.key,
    required this.type,
    this.size = 80.0,
    this.colorOverride,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    if (colorOverride != null) {
      baseColor = colorOverride!;
    } else {
      switch (type) {
        case MoodType.happy:
          baseColor = AppColors.happy;
          break;
        case MoodType.neutral:
          baseColor = AppColors.neutral;
          break;
        case MoodType.sad:
          baseColor = AppColors.sad;
          break;
      }
    }

    return SizedBox(
      width: size,
      height: size,
      child: const SizedBox()
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .custom(
            duration: 1500.ms,
            builder: (context, value, child) {
              return CustomPaint(
                painter: MoodPainter(
                  type: type,
                  baseColor: baseColor,
                  animationValue: value,
                ),
              );
            },
          ),
    );
  }
}
