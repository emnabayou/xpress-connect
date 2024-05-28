import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/features/4-activation/data.dart';
import 'package:xcmobile/features/4-activation/models/activation_method_model.dart';
import 'package:xcmobile/features/4-activation/models/activation_offer_model.dart';

const int onBoardingIndex = 0;
const int onBoardingIdScannerIndex = 1;
const int idScannerIndex = 2;
const int onBoardingSimScannerIndex = 3;
const int simScannerIndex = 4;
const int chooseOfferIndex = 5;
const int chooseNumeroIndex = 6;

class ActivationChangeNotifier extends ChangeNotifier {
  final PageController _pageController = PageController();
  final int _steps = 7;
  int _currentStep = 0;
  ActivationOfferModel _selectedOffer = activationOffers.first;
  String _scannedBarcode = "";

  ActivationMethodModel _selectedMethod = activationMethods.first;

  //getters
  PageController get pageController => _pageController;
  int get currentStep => _currentStep;
  double get stepProgress =>
      _currentStep != 0 ? (_currentStep / _steps) * 100 : 0;
  ActivationMethodModel get selectedMethod => _selectedMethod;
  ActivationOfferModel get selectedOffer => _selectedOffer;
  String get scannedBarcode => _scannedBarcode;


  changeStep(int value) {
    _currentStep = value;
    notifyListeners();
    _pageController.animateToPage(value,
        curve: Curves.easeInOut, duration: const Duration(milliseconds: 220));
  }

  handleBack() {
    if (_currentStep <= 0) {
      return;
    }
    _currentStep = _currentStep - 1;
    notifyListeners();
    _pageController.animateToPage(_currentStep,
        curve: Curves.easeInOut, duration: const Duration(milliseconds: 220));
  }

  handleRetry() {
    _currentStep = 0;
    _selectedOffer = activationOffers.first;
    _scannedBarcode = "";
    _selectedMethod = activationMethods.first;
    notifyListeners();
    _pageController.jumpTo(0);
  }

  setSelectedMethod(ActivationMethodModel method) {
    _selectedMethod = method;
    notifyListeners();
  }

  setScannedBarcode(String barcode) {
    _scannedBarcode = barcode;
    notifyListeners();
  }

  setSelectedOffer(ActivationOfferModel offer) {
    _selectedOffer = offer;
    notifyListeners();
  }
}

final activationChangeNotifer =
    ChangeNotifierProvider<ActivationChangeNotifier>(
  (ref) => ActivationChangeNotifier(),
);
