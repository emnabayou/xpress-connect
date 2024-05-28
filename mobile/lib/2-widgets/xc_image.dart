import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class XCImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final GlobalKey? imageKey;

  const XCImage(
      {required this.imageUrl,
      this.fit,
      this.width,
      this.height,
      this.imageKey,
      super.key});

  static Widget base64(String? base64String) {
    if (base64String == null) {
      //return const Text("error");
      return Image.asset("assets/images/rnta.png");
    }
    final bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      height: 80,
    );
  }

  static Widget asset(
      {required String imageUrl, BoxFit fit = BoxFit.cover, double? width, double? height}) {
    return Image.asset(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, url, error) {
        return const Text("Erreur de chargement de l'image");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: imageKey,
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorWidget: (context, url, error) {
        return const Text("Erreur de chargement de l'image");
      },
    );
  }
}
