// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';

class SimScanner extends ConsumerStatefulWidget {
  const SimScanner({super.key});

  @override
  ConsumerState<SimScanner> createState() => _SimScannerState();
}

class _SimScannerState extends ConsumerState<SimScanner> {
  List<String?> barcodes = [];
  String? selectedBarcode;

  ScreenshotController screenshotController = ScreenshotController();
  bool captured = false;
  Uint8List? capturedImage;
  bool loadingVerification = false;
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationChangeNotifier).setDisplaynavigationBars(false);
    });
  }

  Future<void> _handleDetection(BarcodeCapture capture) async {
    List<String?> list =
        capture.barcodes.map((e) => e.rawValue).toSet().toList();
    if (list.length < barcodes.length) {
      return log(
          "obtained result in less than current result!, no need to refresh result list");
    }
    if (listEquals<String?>(list, barcodes)) {
      return log(
          "same barcode scan result captured!, no need to refresh result list");
    }

    if (selectedBarcode != list.firstOrNull) {
      log("barcode changed, recapturing new image");
      await _capture();
    }
    if (!captured) {
      await _capture();
    }
    setState(() {
      barcodes = list;
      selectedBarcode = list.firstOrNull;
    });
    ref.read(navigationChangeNotifier).setDisplaynavigationBars(true);
    verifySimCard();
    return;
  }

  verifySimCard() async {
    setState(() => loadingVerification = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loadingVerification = false;
      isVerified = true;
    });
  }

  void _handleSelectItem(String? barcode) {
    setState(() {
      selectedBarcode = barcode;
    });
  }

  void _handleRetry() {
    setState(() {
      barcodes = [];
      selectedBarcode = null;
      captured = false;
      capturedImage = null;
      loadingVerification = false;
      isVerified = false;
    });
    ref.read(navigationChangeNotifier).setDisplaynavigationBars(false);
  }

  void _handleConfirm() {
    if (selectedBarcode == null) {
      return;
    }
    ref.read(navigationChangeNotifier).setDisplaynavigationBars(true);
    ref.read(activationChangeNotifer).setScannedBarcode(selectedBarcode!);
    ref.read(activationChangeNotifer).changeStep(chooseOfferIndex);
  }

  Widget _buildSimImageViewer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(
        capturedImage!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildResultItem(String? barcode) {
    return InkWell(
      onTap: () => _handleSelectItem(barcode),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                capturedImage != null
                    ? _buildSimImageViewer()
                    : const SizedBox(),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Numero de serie", style: AppTextStyles.bodyLg),
                    Text(barcode ?? "undefined"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildResultDialog() {
    return barcodes.isNotEmpty
        ? Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text("Resultat")),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: barcodes
                              .map((barcode) => _buildResultItem(barcode))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  loadingVerification
                      ? const XCCircularProgressIndicator()
                      : isVerified
                          ? const Icon(Icons.verified_outlined)
                          : const Icon(Icons.error_outline),
                  const SizedBox(height: 10),
                  loadingVerification
                      ? const Text("Vérification en cours")
                      : isVerified
                          ? const Text("Vérifié")
                          : const Text("Une erreur s'est produite"),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                            onPressed:
                                selectedBarcode != null ? _handleConfirm : null,
                            child: const Text("Continuer")),
                        TextButton(
                            onPressed: _handleRetry,
                            child: const Text("Réessayer")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  Future<void> _capture() async {
    try {
      log("capture sim barcode for info centre");
      final image = await screenshotController.capture();
      if (image == null) {
        return log("captured image is null : $image");
      }
      log("captured sim barcode successfully");
      setState(() {
        capturedImage = image;
        captured = true;
      });
    } catch (e) {
      log("error in capturing barcode image: $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: barcodes.isEmpty
                ? MobileScanner(
                    onDetect: _handleDetection,
                  )
                : Container(
                    color: Colors.white,
                  ),
          ),
          _buildResultDialog()
        ],
      ),
    );
  }
}

class BackgroundOverlay extends StatelessWidget {
  final Widget child;
  const BackgroundOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: [
          Container(
            width: widthFromPercentage(context, 100),
            height: heightFromPercentage(context, 100),
            color: AppColors.black.withOpacity(0.5),
          ),
          child
        ],
      ),
    );
  }
}
