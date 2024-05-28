import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeIn(
          duration: const Duration(milliseconds: 200),
          child: Opacity(
            opacity: 0.1,
            child: XCImage.asset(
              imageUrl: "assets/images/abstract.jpg",
              width: widthFromPercentage(context, 100),
              height: heightFromPercentage(context, 100),
            ),
          ),
        ),
        child,
      ],
    );
  }
}