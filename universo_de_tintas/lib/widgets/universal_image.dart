import 'dart:io';
import 'package:flutter/material.dart';

class UniversalImage extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;

  const UniversalImage({
    super.key,
    required this.imagePath,
    this.width = 80,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath!.startsWith("assets/")) {
      return Image.asset(
        imagePath!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }

    if (Uri.parse(imagePath!).isAbsolute) {
      return Image.network(
        imagePath!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
            "assets/images/imagen_defecto_user.png",
            width: width,
            height: height),
      );
    }

    if (File(imagePath!).existsSync()) {
      return Image.file(
        File(imagePath!),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      "assets/images/imagen_defecto_user.png",
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
