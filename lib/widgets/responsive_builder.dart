import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const ResponsiveBuilder({super.key, required this.mobile, this.tablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600 && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}