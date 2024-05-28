import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/features/3-navigation/models/navigation_model.dart';

class NavigationChangeNotifier extends ChangeNotifier {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  int _selectedPage = 0;
  String _appBarTitle = "";
  bool _displaynavigationBars = true;

  int get selectedPage => _selectedPage;
  String get appBarTitle => _appBarTitle;
  bool get displaynavigationBars => _displaynavigationBars;


  static final _menuItems = [
    NavigationModel(
        index: 0,
        title: "Dashboard",
        titleAppbar: "Dashboard",
        icon: CupertinoIcons.chart_pie,
        iconFill: CupertinoIcons.chart_pie_fill),
    NavigationModel(
        index: 1,
        title: "Historique",
        titleAppbar: "Historique",
        icon: CupertinoIcons.doc_text,
        iconFill: CupertinoIcons.doc_text_fill),
    NavigationModel(
        index: 2,
        title: "Activation",
        titleAppbar: "Activation",
        icon: CupertinoIcons.rectangle_stack_badge_plus,
        iconFill: CupertinoIcons.rectangle_stack_badge_plus),
    NavigationModel(
        index: 3,
        title: "Stock",
        titleAppbar: "Stock disponible",
        icon: CupertinoIcons.cube_box,
        iconFill: CupertinoIcons.cube_box_fill),
    NavigationModel(
      index: 3,
      title: "Profil",
      titleAppbar: "Profil",
      icon: CupertinoIcons.profile_circled,
      iconFill: CupertinoIcons.profile_circled,
    )
  ];
  List<NavigationModel> get menuItems => _menuItems;

  initAppBarTitle() {
    _appBarTitle = _menuItems[0].titleAppbar;
    notifyListeners();
  }

  void onDestinationSelected(int index) async {
    _appBarTitle = _menuItems[index].titleAppbar;
    _selectedPage = index;
    _pageController.jumpToPage(
      index,
    );
    notifyListeners();
  }

  void reset() {
    _appBarTitle = _menuItems[0].titleAppbar;
    _selectedPage = 0;
    notifyListeners();
  }

  void setDisplaynavigationBars(bool value){
    _displaynavigationBars = value;
    notifyListeners();
  }
}

final navigationChangeNotifier =
    ChangeNotifierProvider<NavigationChangeNotifier>(
  (ref) => NavigationChangeNotifier(),
);
