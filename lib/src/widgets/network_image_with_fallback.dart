import 'package:flutter/material.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAsset;
  final double? width, height;

  const NetworkImageWithFallback(
      {super.key,
      required this.imageUrl,
      required this.fallbackAsset,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _recipeImageDefault(context);
    }

    return Image.network(imageUrl!,
        height: height,
        width: width,
        fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
      return _recipeImageDefault(context);
    }, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return _recipeImageLoading(context, loadingProgress);
    });
  }

  Image _recipeImageDefault(BuildContext context) {
    return Image.asset(
      fallbackAsset,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  Center _recipeImageLoading(
      BuildContext context, ImageChunkEvent loadingProgress) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }
}
