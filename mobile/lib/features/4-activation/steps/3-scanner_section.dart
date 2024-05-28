// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_text_recognizer/google_ml_text_recognizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrz_parser/mrz_parser.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/interfaces/text_recognizer.dart';
import 'package:xcmobile/features/4-activation/models/recognition_response.dart';
import 'package:xcmobile/features/4-activation/providers/activation_change_notifier.dart';
import 'package:xcmobile/features/4-activation/recognizer/mlkit_text_recognizer.dart';

class IdScanner extends ConsumerStatefulWidget {
  const IdScanner({super.key});

  @override
  ConsumerState<IdScanner> createState() => _IdScannerState();
}

class _IdScannerState extends ConsumerState<IdScanner>
    with WidgetsBindingObserver {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;
  RecognitionResponse? _response;
  bool isLoading = false;
  bool cameraInitialized = false;
  bool cameraInitError = false;
  List<CameraDescription> cameras = [];
  CameraController? _controller;

  static const double cameraCaptureAreaHeight = 150;
  static const double mrzAreaPosition = 200;

  // for tap to focus
  bool showFocusCircle = false;
  double focusX = 0;
  double focusY = 0;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    /// Can be [MLKitTextRecognizer] or [TesseractTextRecognizer]
    _recognizer = MLKitTextRecognizer();
    initCamera();
  }

  initCamera() async {
    setState(() {
      cameraInitialized = false;
      _response = null;
    });
    cameras = await availableCameras();
    final camera = cameras.firstOrNull;
    if (camera == null) {
      return log("camera list is empty");
    }
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    _controller?.initialize().then((_) {
      log("camera init done");
      if (!mounted) {
        setState(() => cameraInitError = true);
        return;
      }
      ref.read(navigationChangeNotifier).setDisplaynavigationBars(false);

      //_controller?.startImageStream(_processCameraImage);
      setState(() => cameraInitialized = true);
    });
    /*final imgPath = await obtainImage(ImageSource.camera);
    if (imgPath == null) {
      AppSnackBar().showSnackBar(context,
          title: "Une erreur s'est produite. réessayez plus tard");
      return;
    }

    processImage(imgPath);*/
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
    _controller?.dispose();
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras.firstOrNull;
    if (camera == null) {
      return;
    }
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    log("found input image :$inputImage");
    //widget.onImage(inputImage);
  }

  void processImage(String imgPath) async {
    setState(() => isLoading = true);
    final recognizedText = await _recognizer.processImage(imgPath);
    final recognizedTextParts = recognizedText.split("\n");
    final mrzParts =
        recognizedTextParts.where((element) => element.contains("<"));
    final mrz = mrzParts.join().replaceAll('«', '<').replaceAll(' ', '');
    final mrzResult = getDataFromMRZ(mrz);
    setState(() {
      _response = RecognitionResponse(
        imgPath: imgPath,
        recognizedText: recognizedText,
        mrz: mrz,
        mrzResult: mrzResult,
      );
      isLoading = false;
    });
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  MRZResult? getDataFromMRZ(String mrz) {
    try {
      log("parsing mrz :$mrz with length ${mrz.length}");
      final firstPart = mrz.substring(0, (mrz.length / 2).round());
      final secondPart = mrz.substring((mrz.length / 2).round(), mrz.length);
      log("mrz parts :${[firstPart, secondPart]}");

      final result = MRZParser.tryParse([firstPart, secondPart]);
      return result;
    } catch (e) {
      log("error parsing mrz :$e");
      return null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null) {
      return;
    }
    if (!_controller!.value.isInitialized) return;
    if (_controller!.value.isTakingPicture) return;
    try {
      await _controller?.setFocusMode(FocusMode.auto);
      await _controller?.setFocusPoint(const Offset(0.5, 0.6));

      XFile picture = await _controller!.takePicture();

      processImage(picture.path);
      ref.read(navigationChangeNotifier).setDisplaynavigationBars(true);
    } on CameraException catch (e) {
      log('Error occured while taking picture: $e');
    }
  }

  Future<void> _onTap(TapUpDetails details) async {
    if (_controller == null || _controller?.value.isInitialized == false) {
      return;
    }

    showFocusCircle = true;
    focusX = details.localPosition.dx;
    focusY = details.localPosition.dy;

    double fullWidth = widthFromPercentage(context, 100);
    double cameraHeight = fullWidth *
        (_controller?.value.aspectRatio ?? heightFromPercentage(context, 100));

    double xp = focusX / fullWidth;
    double yp = focusY / cameraHeight;

    Offset point = Offset(xp, yp);
    log("point : $point");

    // Manually focus
    await _controller?.setFocusPoint(point);

    // Manually set light exposure
    _controller?.setExposurePoint(point);

    setState(() {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        setState(() {
          showFocusCircle = false;
        });
      });
    });
  }

  Widget _buildCameraView() {
    return cameraInitialized
        ? GestureDetector(
            onTapUp: _onTap,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: widthFromPercentage(context, 100),
                  height: heightFromPercentage(context, 100),
                  child: CameraPreview(_controller!),
                ),
                Container(
                  width: widthFromPercentage(context, 100),
                  height: heightFromPercentage(context, 100),
                  color: Colors.black.withOpacity(0.5),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: mrzAreaPosition,
                        child: ZoomIn(
                          delay: const Duration(milliseconds: 500),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.05),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]),
                            height: 70,
                            // Blue color with opacity
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.black.withOpacity(0),
                        AppColors.black.withOpacity(0.2),
                        AppColors.black.withOpacity(0.5),
                        AppColors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                  width: widthFromPercentage(context, 100),
                  height: cameraCaptureAreaHeight,
                  child: Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.white.withOpacity(0.3),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: _takePicture,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.white, width: 4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (showFocusCircle)
                  Positioned(
                    top: focusY - 20,
                    left: focusX - 20,
                    child: ZoomIn(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 1.5)),
                      ),
                    ),
                  )
              ],
            ),
          )
        : cameraInitError
            ? const Text("Camera not initalized")
            : const Center(child: XCCircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  XCCircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Veuillez patienter')
                ],
              ),
            )
          : _response == null
              ? _buildCameraView()
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      "Pièce d’identité",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: heightFromPercentage(context, 35),
                      child: Image.file(
                        File(_response!.imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Type: ",
                              style: AppTextStyles.bodyLg
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                ref
                                    .watch(activationChangeNotifer)
                                    .selectedMethod
                                    .title,
                                style: AppTextStyles.bodyLg),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Numéro: ",
                              style: AppTextStyles.bodyLg
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text("${_response!.mrzResult?.documentNumber}",
                                style: AppTextStyles.bodyLg),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("Pays: ${_response!.mrzResult?.countryCode}"),
                        Text("Prénom: ${_response!.mrzResult?.givenNames}"),
                        Text("Nom: ${_response!.mrzResult?.surnames}"),
                        Text(
                            "Nationalité: ${_response!.mrzResult?.nationalityCountryCode}"),
                        if (_response?.mrzResult?.birthDate != null)
                          Text(
                              "Date de naissance: ${Configs.dayFormat.format(_response!.mrzResult!.birthDate)}"),
                        if (_response?.mrzResult?.expiryDate != null)
                          Text(
                              "Date d’expiration: ${Configs.dayFormat.format(_response!.mrzResult!.expiryDate)}"),
                        Text("Sexe: ${_response!.mrzResult?.sex.name}"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: initCamera,
                                child: const Text("Réessayer")),
                            FilledButton(
                                onPressed: () {
                                  ref
                                      .read(activationChangeNotifer)
                                      .changeStep(onBoardingSimScannerIndex);
                                },
                                child: const Text("Continuer")),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
    );
  }
}

class RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(
          0, 0, size.width, size.height)); // Add the full rectangle

    final double holeWidth = 300; // Width of the hole
    final double holeHeight = 100; // Height of the hole
    final holeLeft = (size.width - holeWidth) / 2; // Left position of the hole
    final holeTop = (size.height - holeHeight) / 2; // Top position of the hole

    final holeRect = Rect.fromLTWH(holeLeft, holeTop, holeWidth, holeHeight);
    path.addRect(holeRect); // Add the hole rectangle

    return path
      ..fillType = PathFillType
          .evenOdd; // Combine the rectangles with an even-odd rule to create a hole
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
