import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'app_shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        // 1. Smooth Fade-in
        fadeInDuration: const Duration(milliseconds: 500),
        
        // 2. While Loading: Use our Shimmer
        placeholder: (context, url) => AppShimmer(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: borderRadius,
        ),

        // 3. On Error: Show a neutral icon
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
        ),
      ),
    );
  }
}