import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/2-widgets/xc_modal.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';

import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/steps/1-onboarding.dart';
import 'package:xcmobile/features/4-activation/steps/2-on_boarding_id_scanner.dart';
import 'package:xcmobile/features/4-activation/steps/3-scanner_section.dart';
import 'package:xcmobile/features/4-activation/steps/4-on_boarding_sim_scanner.dart';
import 'package:xcmobile/features/4-activation/steps/5-sim_scanner.dart';
import 'package:xcmobile/features/4-activation/steps/6-choose-offer.dart';
import 'package:xcmobile/features/4-activation/steps/7-choose-numero.dart';
import 'package:xcmobile/features/4-activation/widgets/xc_linear_progress_indicator.dart';

class ActivationPage extends ConsumerStatefulWidget {
  const ActivationPage({super.key});

  @override
  ConsumerState<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends ConsumerState<ActivationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final stepProgress = ref.watch(activationChangeNotifer).stepProgress;
    final pageController = ref.read(activationChangeNotifer).pageController;
    final handleRetry = ref.read(activationChangeNotifer).handleRetry;
    final currentStep = ref.watch(activationChangeNotifer).currentStep;
    final displaynavigationBars =
        ref.watch(navigationChangeNotifier).displaynavigationBars;

    handleConfirm() {
      XCModal().openDialog(
        context,
        image: const Icon(Icons.restore, size: 40),
        topBarTitle: "réinitialisation",
        title:
            "etes-vous sûr de vouloir réinitialiser votre session ? Cette action mettra fin à votre activation en cours.",
        confirmTitle: "Confirmer",
        cancelTitle: "Annuler",
        onConfirm: () {
          ref.read(navigationChangeNotifier).setDisplaynavigationBars(true);
          AppSnackBar().showSnackBar(context,
              title: "Votre activation a été réinitialisé");
          handleRetry();
        },
      );
    }

    handleBackButton() {
      ref.read(navigationChangeNotifier).setDisplaynavigationBars(true);
      ref.read(activationChangeNotifer).handleBack();
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Visibility(
                  visible: displaynavigationBars,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: currentStep != 0 ? handleBackButton : null,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      XCLinearProgressIndicator(progress: stepProgress),
                      IconButton(
                        onPressed: currentStep != 0 ? handleConfirm : null,
                        icon: const Icon(Icons.autorenew_rounded),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      OnBoarding(),
                      OnBoardingIdScanner(),
                      IdScanner(),
                      OnBoardingSimScanner(),
                      SimScanner(),
                      ChooseOffer(),
                      ChooseNumero(),
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: displaynavigationBars==false,
              child: SafeArea(
                top: displaynavigationBars == false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentStep != 0 ? handleBackButton : null,
                      icon: const Icon(Icons.arrow_back,color: AppColors.white),
                    ),
                    XCLinearProgressIndicator(progress: stepProgress,color: AppColors.white),
                    IconButton(
                      onPressed: currentStep != 0 ? handleConfirm : null,
                      icon: const Icon(Icons.autorenew_rounded,color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
