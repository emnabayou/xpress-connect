import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/4-activation/models/activation_method_model.dart';


class ActivationMethodItem extends ConsumerWidget {
  final ActivationMethodModel method;
  final bool isChecked;
  final Function() onPressed;
  const ActivationMethodItem(
      this.method,
      {
      required this.isChecked,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.inputFill,
            border: isChecked
                ? Border.all(color: AppColors.primary, width: 2)
                : Border.all(color: AppColors.inputStoke, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: heightFromPercentage(context, 6),
                    height: heightFromPercentage(context, 6),
                    child: XCImage.asset(
                      imageUrl: method.image,
                    )),
                    const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(method.title),
                    Text(method.description,
                      style: TextStyle(color: AppColors.black.withOpacity(0.6)),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey.withOpacity(0.1),
                  border: isChecked
                      ? Border.all(
                          color: AppColors.primary, width: 2)
                      : const Border.fromBorderSide(BorderSide.none)),
              child: isChecked
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
