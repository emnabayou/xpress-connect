import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/models/activation_offer_model.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';

class ChooseOffer extends ConsumerStatefulWidget {
  const ChooseOffer({super.key});

  @override
  ConsumerState<ChooseOffer> createState() => _ChooseOfferState();
}

class _ChooseOfferState extends ConsumerState<ChooseOffer> {

  Widget _checkIndicator(ActivationOfferModel offer) {
    final isChecked =
        offer.id == ref.watch(activationChangeNotifer).selectedOffer.id;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.card,
          border: isChecked
              ? Border.all(color: AppColors.primary, width: 2)
              : const Border.fromBorderSide(BorderSide.none)),
      child: isChecked
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
              ),
            )
          : const SizedBox(),
    );
  }

  void _handleSelectItem(ActivationOfferModel offer) {
    ref.read(activationChangeNotifer).setSelectedOffer(offer);
  }

  _buildOfferItem(ActivationOfferModel offer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.card,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _handleSelectItem(offer),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(offer.title),
                  ],
                ),
                _checkIndicator(offer)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              XCImage.asset(imageUrl: "assets/logos/choose-offer.png"),
              const Text(
                "Offre",
                style: AppTextStyles.h3,
              ),
              const Text(
                "Sélectionnez l’offre de votre activation.",
                style: AppTextStyles.bodyLg,
              ),
              const SizedBox(height: 10),
              ...activationOffers.map((offer) => _buildOfferItem(offer)),
              const SizedBox(height: 5),
              FilledButton(
                onPressed: () {
                  ref
                      .read(activationChangeNotifer)
                      .changeStep(chooseNumeroIndex);
                },
                child: const Text("Continuer"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
