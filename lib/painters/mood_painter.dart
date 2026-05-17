import 'dart:math';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../core/constants/app_colors.dart';

class MoodPainter extends CustomPainter {
  final MoodType type;
  final Color baseColor;
  final double animationValue;

  MoodPainter({
    required this.type,
    required this.baseColor,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);


    final facePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    // Face outline
    final outlinePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08;
    canvas.drawCircle(center, radius, outlinePaint);

    // Common features paint
    final featurePaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.12;

    final fillPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;

    final eyeRadius = radius * 0.12;
  
    double eyeSquash = 1.0;
    if (animationValue > 0.8) {
      // squash from 1.0 down to 0.1 and back
      double t = (animationValue - 0.8) / 0.2; // 0 to 1
      eyeSquash = 1.0 - (sin(t * pi) * 0.8);
    }
    
    final eyeHeight = eyeRadius * eyeSquash;

    final leftEyeRect = Rect.fromCenter(
        center: Offset(center.dx - radius * 0.35, center.dy - radius * 0.2),
        width: eyeRadius * 2,
        height: eyeHeight * 2);
    final rightEyeRect = Rect.fromCenter(
        center: Offset(center.dx + radius * 0.35, center.dy - radius * 0.2),
        width: eyeRadius * 2,
        height: eyeHeight * 2);
    canvas.drawOval(leftEyeRect, fillPaint);
    canvas.drawOval(rightEyeRect, fillPaint);

    // Expressions
    switch (type) {
      case MoodType.happy:
        _drawHappy(canvas, center, radius, featurePaint, animationValue);
        break;
      case MoodType.neutral:
        _drawNeutral(canvas, center, radius, featurePaint, animationValue);
        break;
      case MoodType.sad:
        _drawSad(canvas, center, radius, featurePaint, animationValue);
        break;
    }
  }

  void _drawHappy(Canvas canvas, Offset center, double radius, Paint paint, double anim) {

    final mouthCenter = Offset(center.dx, center.dy - anim * radius * 0.05);
    final rect = Rect.fromCircle(center: mouthCenter, radius: radius * 0.5);
    canvas.drawArc(rect, 0.2, pi - 0.4, false, paint);

    // Eyebrows move up
    final eyebrowPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.1;
    
    final browOffset = anim * radius * 0.05;
    final leftEyebrowRect = Rect.fromCircle(
        center: Offset(center.dx - radius * 0.35, center.dy - radius * 0.35 - browOffset),
        radius: radius * 0.2);
    canvas.drawArc(leftEyebrowRect, pi, pi, false, eyebrowPaint);

    final rightEyebrowRect = Rect.fromCircle(
        center: Offset(center.dx + radius * 0.35, center.dy - radius * 0.35 - browOffset),
        radius: radius * 0.2);
    canvas.drawArc(rightEyebrowRect, pi, pi, false, eyebrowPaint);
  }

  void _drawNeutral(Canvas canvas, Offset center, double radius, Paint paint, double anim) {

    final mOffset = anim * radius * 0.03;
    final leftMouth = Offset(center.dx - radius * 0.3, center.dy + radius * 0.3 + mOffset);
    final rightMouth = Offset(center.dx + radius * 0.3, center.dy + radius * 0.3 + mOffset);
    canvas.drawLine(leftMouth, rightMouth, paint);

    // Eyebrows
    final eyebrowPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.1;

    final browOffset = anim * radius * 0.03;
    final leftBrowStart = Offset(center.dx - radius * 0.5, center.dy - radius * 0.4 + browOffset);
    final leftBrowEnd = Offset(center.dx - radius * 0.2, center.dy - radius * 0.4 + browOffset);
    canvas.drawLine(leftBrowStart, leftBrowEnd, eyebrowPaint);

    final rightBrowStart = Offset(center.dx + radius * 0.2, center.dy - radius * 0.4 + browOffset);
    final rightBrowEnd = Offset(center.dx + radius * 0.5, center.dy - radius * 0.4 + browOffset);
    canvas.drawLine(rightBrowStart, rightBrowEnd, eyebrowPaint);
  }

  void _drawSad(Canvas canvas, Offset center, double radius, Paint paint, double anim) {
   
    final mOffset = anim * radius * 0.04;
    final rect = Rect.fromCircle(center: Offset(center.dx, center.dy + radius * 0.6 + mOffset), radius: radius * 0.4);
    canvas.drawArc(rect, pi + 0.4, pi - 0.8, false, paint);

    // Eyebrows move down and angle slightly more
    final eyebrowPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.1;

    final browOffset = anim * radius * 0.05;
    final leftBrowStart = Offset(center.dx - radius * 0.5, center.dy - radius * 0.35 + browOffset);
    final leftBrowEnd = Offset(center.dx - radius * 0.2, center.dy - radius * 0.45 + browOffset);
    canvas.drawLine(leftBrowStart, leftBrowEnd, eyebrowPaint);

    final rightBrowStart = Offset(center.dx + radius * 0.2, center.dy - radius * 0.45 + browOffset);
    final rightBrowEnd = Offset(center.dx + radius * 0.5, center.dy - radius * 0.35 + browOffset);
    canvas.drawLine(rightBrowStart, rightBrowEnd, eyebrowPaint);


    final rightEyePos = Offset(center.dx + radius * 0.35, center.dy - radius * 0.15);
    final dropDistance = anim * radius * 0.4;
    final tearCenter = Offset(rightEyePos.dx + radius * 0.05, rightEyePos.dy + dropDistance);
    
    // Fade out as it drops
    final tearAlpha = (1.0 - anim).clamp(0.0, 1.0);
    final tearPaint = Paint()
      ..color = AppColors.tearDrop.withValues(alpha: tearAlpha)
      ..style = PaintingStyle.fill;
    
    // Draw tear (small oval)
    final tearRect = Rect.fromCenter(
      center: tearCenter, 
      width: radius * 0.06, 
      height: radius * 0.12,
    );
    canvas.drawOval(tearRect, tearPaint);
  }

  @override
  bool shouldRepaint(covariant MoodPainter oldDelegate) {
    return oldDelegate.type != type || 
           oldDelegate.baseColor != baseColor || 
           oldDelegate.animationValue != animationValue;
  }
}
