import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/3-utils/responsive.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/2-authentification/views/login_page.dart';
import 'package:xcmobile/features/2-authentification/views/terms_and_conditions.dart';
import 'package:xcmobile/features/3-navigation/navigation_page.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';

class PincodePage extends ConsumerStatefulWidget {
  static const String route = "/pin";

  const PincodePage({super.key});

  @override
  ConsumerState<PincodePage> createState() => _PincodeSectionState();
}

class _PincodeSectionState extends ConsumerState<PincodePage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isNotValid = false;
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  String? handlePinCode(String? value) {
    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 2)).then((seconds) {
      setState(() => isLoading = false);
      if (value != "0000") {
        setState(() => isNotValid = true);
        return;
      }
      XCBoxes.authBox.put('token', "token");

      Navigator.popUntil(context, ModalRoute.withName(LoginPage.route));

      final acceptedTerms = XCBoxes.settingsBox.get('acceptedTerms');
      if (acceptedTerms != true) {
        Navigator.popAndPushNamed(context, TermsAndConditions.route);
        return;
      }
      AppSnackBar().showSnackBar(context, title: "Vous êtes connecté!");
      Navigator.popAndPushNamed(context, HomePage.route);
      return null;
    });

    return null;
  }

  Widget _buildPinPut() {
    const focusedBorderColor = AppColors.primary;
    final fillColor = AppColors.secondary.withOpacity(0.2);
    const borderColor = AppColors.secondary;
    const textColor = AppColors.primary;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: textColor.withOpacity(0.8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Pinput(
          autofocus: true,
          controller: pinController,
          focusNode: focusNode,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: defaultPinTheme,
          //closeKeyboardWhenCompleted: false,
          separatorBuilder: (index) => const SizedBox(width: 8),
          validator: handlePinCode,
          /*onClipboardFound: (value) {
            debugPrint('onClipboardFound: $value');
            pinController.setText(value);
          },*/
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: (pin) {
            debugPrint('onCompleted: $pin');
          },
          onChanged: (value) {
            debugPrint('onChanged: $value');
          },
          forceErrorState: isNotValid,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: focusedBorderColor,
              ),
            ],
          ),
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: focusedBorderColor),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              color: fillColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: focusedBorderColor),
            ),
          ),
          errorPinTheme: defaultPinTheme
              .copyWith(
                  textStyle:
                      const TextStyle(fontSize: 22, color: AppColors.error))
              .copyBorderWith(
                border: Border.all(color: AppColors.error),
              ),
        ),
        IconButton(
            onPressed: () {
              pinController.clear();
              focusNode.requestFocus();
              setState(() => isNotValid = false);
            },
            icon: const Icon(CupertinoIcons.delete_left))
      ],
    );
  }

  double? _handleResponsiveSize() {
    if (Responsive.isHorizantalTablet(context)) {
      return widthFromPercentage(context, 30);
    }

    if (Responsive.isTablet(context)) {
      return widthFromPercentage(context, 50);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification"),
      ),
      body: Center(
        child: Container(
          width: _handleResponsiveSize(),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Entrer le code de confirmation",
                  style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/logos/pin-message.png",
                  width: widthFromPercentage(context, 25),
                ),
                const Text(
                  "Un code OTP à quatre chiffres a été envoyé sur votre numéro ******47",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(height: heightFromPercentage(context, 3)),
                _buildPinPut(),
                SizedBox(height: heightFromPercentage(context, 1)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Vous n'avez pas reçu le code ?"),
                    TextButton(
                        child: const Text("Renvoyer"),
                        onPressed: () {
                          log("resend code");
                        })
                  ],
                ),
                const SizedBox(height: 20),
                Visibility(
                    visible: isLoading,
                    child: const XCCircularProgressIndicator())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
