import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';


class XCCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? size;
  const XCCircularProgressIndicator(
      {super.key, this.color = AppColors.primary, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: (size != null) ? 2 : 3,
        color: color,
      ),
    );
  }
}
