import 'package:flutter/material.dart';

class MaterialCarosel extends StatelessWidget {

  final List<Widget> children;

  const MaterialCarosel({super.key, required this.children});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CarouselView.weighted(
            itemSnapping: true,
            flexWeights: const [6, 5, 3],
            children: children,
          );
    });
  }
}