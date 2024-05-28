import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/models/activation_offer_model.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';

class ChooseNumero extends ConsumerStatefulWidget {
  const ChooseNumero({super.key});

  @override
  ConsumerState<ChooseNumero> createState() => _ChooseNumeroState();
}

class _ChooseNumeroState extends ConsumerState<ChooseNumero> {
  String? selectedNumber;

  Widget _checkIndicator(String number) {
    final isChecked = number == selectedNumber;
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey.withOpacity(0.8),
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

  void _handleSelectItem(String number) {
    setState(() {
      selectedNumber = number;
    });
  }

  _buildNumberItem(String number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grey,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _handleSelectItem(number),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(number),
                  ],
                ),
                _checkIndicator(number)
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
              const SizedBox(height: 10.0),
              SearchBar(
                  hintText: 'Chercher un numéro',
                  padding:
                      const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  onChanged: (_) => {},
                  leading: const Icon(Icons.search),
                ),
                const SizedBox(height: 15.0),
                ...activationNumbers.map((number) => _buildNumberItem(number)),
                
              FilledButton(
                onPressed: () {
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
