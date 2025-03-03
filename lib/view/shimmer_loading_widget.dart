import 'package:flutter/material.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  
  final bool isLoading;
  final Widget child;

  const ShimmerLoadingWidget(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: child,
        secondChild: child,
        crossFadeState:
            isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 500));
  }
}
