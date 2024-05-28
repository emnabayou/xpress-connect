import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';

class OnBoardingSimScanner extends ConsumerWidget {
  const OnBoardingSimScanner({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedMothod = ref.watch(activationChangeNotifer).selectedMethod;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //XCImage.asset(imageUrl: "assets/images/id_card_2.png", width: 100),
          SizedBox(
            width: 70,
            child: XCImage.asset(imageUrl: "assets/logos/barcode.png"),
          ),
          const Text(
            "SIM",
            style: AppTextStyles.h3,
          ),
          const Text(
              "Scanner le code à barre de votre carte SIM.",
              style: AppTextStyles.bodyLg,textAlign: TextAlign.center,),
          const SizedBox(height: 20),
          FilledButton(
              child: const Text("Scanner"),
              onPressed: () {
                ref.read(activationChangeNotifer).changeStep(simScannerIndex);
              })
        ],
      ),
    );
  }
}
