import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/widgets/activation_method_item.dart';

class OnBoarding extends ConsumerStatefulWidget {
  const OnBoarding({super.key});

  @override
  ConsumerState<OnBoarding> createState() => _OnBoardingSectionState();
}

class _OnBoardingSectionState extends ConsumerState<OnBoarding> {
  bool showMethods = false;

  @override
  Widget build(BuildContext context) {
    final selectedMethod = ref.watch(activationChangeNotifer).selectedMethod;
    final setSelectedMethod =
        ref.read(activationChangeNotifer).setSelectedMethod;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: widthFromPercentage(context, 5)),
            XCImage.asset(
                imageUrl: "assets/images/id_card_2.png",
                width: widthFromPercentage(context, 15)),
            const Text(
              "Pièce d’identité",
              style: AppTextStyles.h3,
            ),
            const Text(
              "Sélectionnez le type de votre pièce d'identité pour l'activation.",
              style: AppTextStyles.bodySm,
            ),
            SizedBox(height: widthFromPercentage(context, 2)),
            showMethods
                ? ZoomIn(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25)
                          .copyWith(bottom: widthFromPercentage(context, 5)),
                      child: Column(
                        children: activationMethods
                            .map((item) => ActivationMethodItem(
                                  item,
                                  isChecked: selectedMethod.id == item.id,
                                  onPressed: () => setSelectedMethod(item),
                                ))
                            .toList(),
                      ),
                    ))
                : const SizedBox(),
            FilledButton(
                child: showMethods
                    ? const Text("Sélectionner")
                    : const Text("Commencer"),
                onPressed: () {
                  if (showMethods == false) {
                    return setState(() => showMethods = true);
                  }
                  ref.read(activationChangeNotifer).changeStep(onBoardingIdScannerIndex);
                })
          ],
        ),
      ),
    );
  }
}
