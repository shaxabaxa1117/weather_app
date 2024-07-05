import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final Widget? child;
  const BlurContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 32,
          sigmaY: 32,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff535353).withOpacity(.2),
          ),
          child: child,
        ),
      ),
    );
  }
}
