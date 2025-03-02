import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_bottom_sheet.dart';

class SheetLayout extends StatelessWidget {
  final Widget header;
  final Widget background;
  final Widget sheet;

  const SheetLayout({
    super.key,
    required this.header,
    required this.background,
    required this.sheet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final BoxConstraints(:maxWidth, :maxHeight) = constraints;
      final bool hasSideSheet = maxWidth >= 840;

      final Widget sideSheetView = Row(
        children: [
          Expanded(
            child: Stack(children: [
              background,
              header,
            ]),
          ),
          SizedBox(
            width: 400.0,
            height: double.maxFinite,
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                child: sheet),
          )
        ],
      );

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: hasSideSheet
            ? sideSheetView
            : MaterialBottomSheet(
                header: header, background: background, content: sheet),
      );
    });
  }
}
