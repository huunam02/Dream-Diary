import 'package:flutter/material.dart';

class ImageNetworkBase extends StatelessWidget {
  const ImageNetworkBase(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image),
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : Container(
                  width: width,
                  height: height,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
    );
  }
}
