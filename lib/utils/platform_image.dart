import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io';

class PlatformImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  const PlatformImage(
      {super.key,
      required this.path,
      this.width = 60,
      this.height = 60,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(path, width: width, height: height, fit: fit);
    } else {
      return Image.file(File(path), width: width, height: height, fit: fit);
    }
  }
}
