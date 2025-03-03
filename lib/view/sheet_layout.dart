import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_bottom_sheet.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_sheet_view.dart';

class SheetLayout extends StatelessWidget implements MaterialSheetView {

  @override
  final MaterialSheetHeaderBuilder headerBuilder;

  @override
  final MaterialSheetListContent content;

  @override
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  const SheetLayout({super.key, required this.headerBuilder, required this.content, required this.backgroundBuilder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final BoxConstraints(:maxWidth, :maxHeight) = constraints;
      final bool hasSideSheet = maxWidth >= 840;

      const Widget sideSheetView = Row(
        children: [
          // Expanded(
          //   child: Stack(children: [
          //     background,
          //     header,
          //   ]),
          // ),
          // SizedBox(
          //   width: 400.0,
          //   height: double.maxFinite,
          //   child: SingleChildScrollView(
          //       padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
          //       child: sheet),
          // )
        ],
      );

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: hasSideSheet
            ? sideSheetView
            : MaterialBottomSheet(
                headerBuilder: headerBuilder,
                content: content,
                backgroundBuilder: backgroundBuilder,
              ),
      );
    });
  }
}
