import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/sheet_layout/material_sheet_layout.dart';

class MaterialSideSheetLayout extends StatelessWidget
    implements MaterialSheetLayout {
  @override
  final MaterialSheetHeader header;

  @override
  final Widget title;

  @override
  final Widget content;

  @override
  final Widget background;

  const MaterialSideSheetLayout({
    super.key,
    required this.header,
    required this.title,
    required this.content,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme(
      :outlineVariant,
      :surfaceContainer,
      :surfaceContainerHighest
    ) = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
            child: Stack(children: [
          background,
          Column(
            children: [
              Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: header.headerBuilder(false)),
            ],
          ),
        ])),
        Container(
          width: 400.0,
          height: double.maxFinite,
          decoration: BoxDecoration(
              border: Border(left: BorderSide(color: outlineVariant))),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
              content,
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
            ],
          ),
        ),
      ],
    );
  }
}
