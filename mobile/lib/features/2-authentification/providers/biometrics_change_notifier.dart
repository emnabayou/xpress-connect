import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/2-widgets/xc_modal.dart';
import 'package:xcmobile/3-utils/snackbar.dart';

import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricsChangeNotifier extends ChangeNotifier {
  String _username = "";
  bool isLoading = false;

  String get username => _username;

  Future<bool> authenticate(context) async {
    final LocalAuthentication auth = LocalAuthentication();
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face)) {
        final bool didAuthenticate = await auth.authenticate(
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Authentification biométrique requise!',
                biometricHint: "vérifier votre identité",
                cancelButton: 'Fermer',
              ),
              IOSAuthMessages(
                cancelButton: 'Fermer',
              )
            ],
            localizedReason:
                'Veuillez vous authentifier pour accéder à votre le compte',
            options: const AuthenticationOptions(biometricOnly: true));
        return didAuthenticate;
      }
      return false;
    } on PlatformException catch (e) {
      log("PlatformException :$e ");
      return false;
    }
  }

  requestBiometrics(context) async {
    final useBiometrics = XCBoxes.settingsBox.get('useBiometrics');
    if (useBiometrics != null) {
      return;
    }
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || isDeviceSupported;

    if (!canAuthenticateWithBiometrics) {
      return log("cannot Authenticate with biometrics");
    }

    if (!isDeviceSupported) {
      return log("device not supported");
    }

    if (!canAuthenticate) {
      return log("cannot authenticate");
    }

    XCModal().openDialog(
      context,
      topBarTitle: "Empreinte",
      image: const Icon(
        Icons.fingerprint,
        size: 60,
        color: AppColors.primary,
      ),
      title:
          "Est-ce que vous seriez intéressé(e) à utiliser votre empreinte digitale comme une autre option d'authentification ?",
      confirmTitle: "Confirmer",
      confirmButtonColor: AppColors.primary,
      confirmTitleColor: AppColors.white,
      cancelTitle: "Annuler",
      onConfirm: () async {
        await XCBoxes.settingsBox.put("useBiometrics", true);
        AppSnackBar().showSnackBar(context,
            title:
                "Succès! Utilisez votre empreinte pour une authentification sécurisée.");
      },
    );
  }
}

final biometricsChangeNotifer =
    ChangeNotifierProvider<BiometricsChangeNotifier>(
  (ref) => BiometricsChangeNotifier(),
);
