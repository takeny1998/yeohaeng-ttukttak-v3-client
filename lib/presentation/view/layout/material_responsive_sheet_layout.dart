import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/domain/entity/material_layout.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/material_layout_provider.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_bottom_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/domain/entity/material_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_side_sheet_layout.dart';

class MaterialResponsiveSheetLayout extends ConsumerWidget
    implements MaterialSheetLayout {
  @override
  final MaterialSheetHeader header;

  @override
  final MaterialSheetContent content;

  @override
  final Widget background;

  @override
  final bool isLoading;

  const MaterialResponsiveSheetLayout({
    super.key,
    required this.header,
    required this.content,
    required this.background,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final layout = ref.watch(materialLayoutProvider);

    final int index = layout.layout < MaterialLayout.large.layout ? 0 : 1;

    return IndexedStack(
      index: index,
      children: [
        MaterialBottomSheetLayout(
          header: header,
          content: content,
          background: background,
          isLoading: isLoading,
        ),
        MaterialSideSheetLayout(
          header: header,
          content: content,
          background: background,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
