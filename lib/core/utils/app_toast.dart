import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppToast {
  static void show(BuildContext context, String message, {IconData icon = Icons.check_circle_rounded, Color? iconColor}) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 32.0,
        right: 32.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: IntrinsicWidth(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p24,
                      vertical: AppSizes.p20,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: iconColor ?? Colors.green, size: 28),
                        const SizedBox(width: AppSizes.p16),
                        Text(
                          message,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      color: (iconColor ?? Colors.green).withValues(alpha: 0.2),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 4,
                        color: iconColor ?? Colors.green,
                        width: double.infinity,
                      ).animate(delay: 400.ms).scaleX(
                            begin: 1.0,
                            end: 0.0,
                            alignment: Alignment.centerLeft,
                            duration: 2500.ms,
                            curve: Curves.linear,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .animate()
          .fadeIn(duration: 400.ms, curve: Curves.easeOutQuad)
          .slideX(begin: 0.5, end: 0, duration: 400.ms, curve: Curves.easeOutCubic)
          .then(delay: 2500.ms)
          .fadeOut(duration: 400.ms)
          .slideX(begin: 0, end: 0.5, duration: 400.ms, curve: Curves.easeInCubic),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    // 400ms in + 2500ms delay + 400ms out = 3300ms total animation
    Future.delayed(const Duration(milliseconds: 3400), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
