// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data_plus/sim_data.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/1-splash_screen/exceptions/denied_location_permission_exception.dart';
import 'package:xcmobile/features/1-splash_screen/exceptions/denied_phone_permission_exception.dart';
import 'package:xcmobile/features/1-splash_screen/exceptions/new_sim_card_installed_exception.dart';
import 'package:xcmobile/features/1-splash_screen/exceptions/no_sim_card_installed_exception.dart';
import 'package:xcmobile/features/2-authentification/providers/biometrics_change_notifier.dart';
import 'package:xcmobile/features/2-authentification/views/login_page.dart';
import 'package:xcmobile/features/2-authentification/views/terms_and_conditions.dart';
import 'package:xcmobile/features/3-navigation/navigation_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  static const route = "/";
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool isLoading = true;
  bool failed = false;
  String xcVersion = XCBoxes.deviceInfoBox.get('version', defaultValue: "");

  @override
  void initState() {
    super.initState();
    initApp();
  }

  bool verifySimCards(List<SimCard> cards, List<String> cardsInStorage) {
    for (SimCard sim in cards) {
      final serialNumber = sim.serialNumber;
      if (!cardsInStorage.contains(serialNumber)) {
        return false;
      }
    }
    return true;
  }

  Future<void> handleSimCards() async {
    final hasPhonePermission = await Permission.phone.isGranted;
    log("hasPhonePermission : $hasPhonePermission");

    SimData simData = await SimDataPlugin.getSimData();
    if (simData.cards.isEmpty) {
      log("no sim cards in your phone");
      throw NoSimCardInstalledException("NoSimCardInstalledException");
    }

    if (XCBoxes.simBox.values.isEmpty) {
      log("no sim cards in storage, fill storage with sim values");
      final List<String> serialNumbers =
          simData.cards.map((sim) => sim.serialNumber).toList();
      await XCBoxes.simBox.addAll(serialNumbers);
      return;
    }

    final simCardsInStorage = XCBoxes.simBox.values.toList();
    final validSimCards = verifySimCards(simData.cards, simCardsInStorage);

    if (!validSimCards) {
      throw NewSimCardInstalledException("NewSimCardInstalledException");
    }
  }

  Future<void> handlePhonePermission() async {
    await Permission.phone.request();
    final phoneStatus = await Permission.phone.status;
    log("phone number permission status :$phoneStatus");
    if (!phoneStatus.isGranted) {
      throw DeniedPhonePermissionException(
          "Vous devez activer la permission pour continue");
    }
  }

  Future<void> handleLocationPermission() async {
    await Permission.location.request();
    final locationStatus = await Permission.location.status;
    log("location permission status :$locationStatus");
    if (!locationStatus.isGranted) {
      throw DeniedLocationPermissionException(
          "Vous devez activer la permission pour continue");
    }
  }

  Future<void> handleCameraPermission() async {
    final status = await Permission.camera.request();
    log("camera permission status :$status");
    if (!status.isGranted) {
      throw DeniedLocationPermissionException(
          "Vous devez activer la permission pour continuer");
    }
  }

  handlenavigation() async {
    //permission handling
    await handlePhonePermission();
    await handleLocationPermission();
    await handleCameraPermission();

    if (!kDebugMode) {
      await handleSimCards();
    }

    //authentification user handling
    final token = XCBoxes.authBox.get("token");
    if (token == null) {
      return Navigator.popAndPushNamed(context, LoginPage.route);
    }

    final acceptedTerms = XCBoxes.settingsBox.get('acceptedTerms');
    if (acceptedTerms != true) {
      return Navigator.popAndPushNamed(context, TermsAndConditions.route);
    }

    //Biometrics permission handling
    bool? useBiometrics = XCBoxes.settingsBox.get("useBiometrics");
    if (useBiometrics != true) {
      //ref.read(navigationChangeNotifier).initAppBarTitle();
      return Navigator.popAndPushNamed(context, HomePage.route);
    }

    final isAuthenticated =
        await ref.read(biometricsChangeNotifer).authenticate(context);
    if (!isAuthenticated) {
      setState(() {
        failed = true;
        isLoading = false;
      });
      return AppSnackBar().showSnackBar(context,
          title: "Une erreur s'est produite. réessayez plus tard");
    }
    return Navigator.popAndPushNamed(context, HomePage.route);
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    setState(() => xcVersion = appVersion.toString());
    await XCBoxes.deviceInfoBox.put('version', appVersion);
  }

  Future<void> initApp() async {
    setState(() {
      failed = false;
      isLoading = true;
    });
    try {
      await getVersion();
      await Future.delayed(const Duration(seconds: 2));
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        setState(() {
          isLoading = false;
          failed = true;
        });
        AppSnackBar().showSnackBar(context, title: "Aucune connexion internet");
        return;
      }
      await handlenavigation();
    } catch (exception) {
      AppSnackBar().showSnackBar(context, title: "$exception");
      setState(() {
        failed = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logos/tt.png",
                      //Lottie.asset("assets/animated/ramadan.json",
                      fit: BoxFit.cover,
                      height: 100),
                  const Text("Xpress Connect"),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: isLoading,
                    child: const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        //color: AppColors.black,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                      visible: failed,
                      child: MaterialButton(
                        onPressed: () {
                          initApp();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh),
                            Text("Retry"),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Positioned(bottom: 0, child: Text("Version $xcVersion")),
          ],
        ),
      ),
    );
  }
}
