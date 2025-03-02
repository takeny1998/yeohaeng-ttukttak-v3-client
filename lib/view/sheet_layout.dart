import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_bottom_sheet.dart';

class SheetLayout extends StatelessWidget {
  final Widget background;

  final Widget sheet;

  const SheetLayout({
    super.key,
    required this.background,
    required this.sheet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final BoxConstraints(:maxWidth, :maxHeight) = constraints;

      if (maxWidth < 840) {
        return Scaffold(
            body: SafeArea(child: background),
            bottomSheet: MaterialBottomSheet(maxHeight: maxHeight, child: sheet));
      }

      return Scaffold(drawer: sheet, body: background);
    });
  }
}
