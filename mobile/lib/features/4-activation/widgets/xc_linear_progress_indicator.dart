import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/config.dart';

class XCLinearProgressIndicator extends StatelessWidget {
  final double progress; 
  final Color color;
  const XCLinearProgressIndicator({
    this.color = AppColors.iconColor,
    required this.progress,super.key});

  @override
  Widget build(BuildContext context) {
    final width = widthFromPercentage(context, 70);
    final progressWidth = width * (progress / 100);
    return Stack(
      children: [
        Container(
          color: color.withOpacity(0.4),
          height: 3,
          width: width,
        ),
        AnimatedContainer(
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 200),
          color: AppColors.primary,
          height: 3,
          width: progressWidth,
        ),
      ],
    );
  }
}
