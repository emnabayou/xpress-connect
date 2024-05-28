import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_themes.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/features/2-authentification/views/login_page.dart';
import 'package:xcmobile/features/2-authentification/views/pincode_page.dart';
import 'package:xcmobile/features/2-authentification/views/terms_and_conditions.dart';
import 'package:xcmobile/features/3-navigation/navigation_page.dart';
import 'package:xcmobile/features/1-splash_screen/splash_page.dart';
import 'package:xcmobile/firebase_options.dart';

GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await XCBoxes().initBoxes();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpress Connect',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.theme,
      //darkTheme: AppThemes.theme,
      builder: (context, child) => Overlay(
        key: overlayKey,
        initialEntries: [OverlayEntry(builder: (context) => child!)],
      ),
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        LoginPage.route: (context) => const LoginPage(),
        HomePage.route: (context) => const HomePage(),
        PincodePage.route: (context) => const PincodePage(),
        TermsAndConditions.route: (context) => const TermsAndConditions()
      },
      initialRoute: SplashPage.route,
    );
  }
}
