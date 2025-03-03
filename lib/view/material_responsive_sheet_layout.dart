import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_bottom_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_side_sheet_layout.dart';

class MaterialResponsiveSheetLayout extends StatelessWidget implements MaterialSheetLayout {
  @override
  final MaterialSheetHeader header;

  @override
  final MaterialSheetListContent content;

  @override
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  const MaterialResponsiveSheetLayout(
      {super.key,
      required this.header,
      required this.content,
      required this.backgroundBuilder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final BoxConstraints(:maxWidth, :maxHeight) = constraints;
      final bool hasSideSheet = maxWidth >= 1200;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: hasSideSheet
            ? MaterialSideSheetLayout(
                header: header,
                content: content,
                backgroundBuilder: backgroundBuilder)
            : MaterialBottomSheetLayout(
                header: header,
                content: content,
                backgroundBuilder: backgroundBuilder,
              ),
      );
    });
  }
}
