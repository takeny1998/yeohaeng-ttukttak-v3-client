import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_bottom_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_side_sheet_layout.dart';

class MaterialResponsiveSheetLayout extends StatelessWidget
    implements MaterialSheetLayout {
  @override
  final MaterialSheetHeader header;

  @override
  final MaterialSheetContent content;

  @override
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  @override
  final bool isLoading;

  const MaterialResponsiveSheetLayout({
    super.key,
    required this.header,
    required this.content,
    required this.backgroundBuilder,
    required this.isLoading,
  });

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
                backgroundBuilder: backgroundBuilder,
                isLoading: isLoading)
            : MaterialBottomSheetLayout(
                header: header,
                content: content,
                backgroundBuilder: backgroundBuilder,
                isLoading: isLoading              ),
      );
    });
  }
}
