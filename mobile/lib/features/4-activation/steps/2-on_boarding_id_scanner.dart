import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';

class OnBoardingIdScanner extends ConsumerWidget {
  const OnBoardingIdScanner({super.key});

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
            width: widthFromPercentage(context, 50),
            height: widthFromPercentage(context, 50),
            child: selectedMothod.id == passportIndex 
            ? Lottie.asset("assets/animated/scan_passport.json")
            : Lottie.asset("assets/animated/id_scan.json"),
          ),
          const SizedBox(height: 20),
          const Text(
            "Pièce d’identité",
            style: AppTextStyles.h3,
          ),
          const Text(
              "Sélectionnez le type de votre pièce d'identité pour l'activation.",
              style: AppTextStyles.bodyLg,textAlign: TextAlign.center,),
          const SizedBox(height: 20),
          FilledButton(
              child: const Text("Scanner"),
              onPressed: () {
                ref.read(activationChangeNotifer).changeStep(idScannerIndex);
              })
        ],
      ),
    );
  }
}
