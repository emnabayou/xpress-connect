// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/features/2-authentification/providers/biometrics_change_notifier.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/activation_page.dart';
import 'package:xcmobile/features/historique_activation/historique_page.dart';
import 'package:xcmobile/features/profile_page/settings_page.dart';
import 'package:xcmobile/features/stock_disponible/stock_page.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricsChangeNotifer).requestBiometrics(context);
      ref.read(navigationChangeNotifier).initAppBarTitle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final onDestinationSelected =
        ref.read(navigationChangeNotifier).onDestinationSelected;
    final pageController = ref.read(navigationChangeNotifier).pageController;
    final appBarTitle = ref.watch(navigationChangeNotifier).appBarTitle;
    final selectedPage = ref.watch(navigationChangeNotifier).selectedPage;
    final menuItems = ref.read(navigationChangeNotifier).menuItems;
    final displaynavigationBars =
        ref.watch(navigationChangeNotifier).displaynavigationBars;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.card,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.card,
    ));
    return Scaffold(
      appBar: displaynavigationBars
          ? AppBar(
              title: Text(
                appBarTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bienvenue",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "0000000054",
                        style: AppTextStyles.body
                            .copyWith(color: AppColors.iconColor),
                      ),
                    ],
                  ),
                ),
              ],
              //backgroundColor: Colors.red.withOpacity(.8),
            )
          : null,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Placeholder(),
          HistoriquePage(),
          ActivationPage(),
          StockPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: displaynavigationBars
          ? NavigationBar(
              elevation: 20,
              backgroundColor: AppColors.card,
              selectedIndex: selectedPage,
              onDestinationSelected: onDestinationSelected,
              surfaceTintColor: AppColors.white,
              shadowColor: Colors.black,
              destinations: menuItems
                  .map((nav) => NavigationDestination(
                        icon: Badge(
                          isLabelVisible: false,
                          child: Icon(nav.icon),
                        ),
                        label: nav.title,
                        selectedIcon: Badge(
                          isLabelVisible: false,
                          child: Icon(nav.iconFill),
                        ),
                      ))
                  .toList())
          : null,
    );
  }
}
