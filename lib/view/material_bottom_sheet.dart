import 'package:flutter/material.dart';

class MaterialBottomSheet extends StatefulWidget {
  final double maxHeight;

  final Widget child;

  const MaterialBottomSheet(
      {super.key, required this.maxHeight, required this.child});

  @override
  State<MaterialBottomSheet> createState() => _MaterialBottomSheetState();
}

class _MaterialBottomSheetState extends State<MaterialBottomSheet> {
  final List<double> positions = [0.4, 1.0];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme(:onSurfaceVariant) =
        Theme.of(context).colorScheme;

    return LayoutBuilder(builder: (context, constraints) {
      final BoxConstraints(:maxWidth, :maxHeight) = constraints;

      return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          height: (maxHeight - MediaQuery.of(context).padding.top) *
              positions[index],
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  final bool isDown = details.delta.dy > 0.0;

                  setState(() {
                    if (isDown && index > 0) {
                      index--;
                    } else if (!isDown && index < 1) {
                      index++;
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0)),
                  ),
                  child: Center(
                    child: Container(
                      width: 32.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                          color: onSurfaceVariant,
                          borderRadius: BorderRadius.circular(16.0)),
                    ),
                  ),
                ),
              ),
              Expanded(child: widget.child)
            ],
          ));
    });
  }
}
