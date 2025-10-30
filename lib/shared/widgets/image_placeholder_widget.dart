import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ImagePlaceholderWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: Container(width: width, height: height, color: Colors.grey[900]),
    );
  }
}
