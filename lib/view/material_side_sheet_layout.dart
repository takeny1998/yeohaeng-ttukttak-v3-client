import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_sheet_view.dart';

class MaterialSideSheetLayout extends StatelessWidget
    implements MaterialSheetView {
  @override
  final MaterialSheetHeaderBuilder headerBuilder;
  @override
  final MaterialSheetListContent content;
  @override
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  const MaterialSideSheetLayout({
    super.key,
    required this.headerBuilder,
    required this.content,
    required this.backgroundBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme(:outlineVariant) = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
            child: LayoutBuilder(
                builder: (context, constraints) => Stack(children: [
                      backgroundBuilder(constraints.maxHeight),
                      Column(
                        children: [
                          Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: headerBuilder(false, false)),
                        ],
                      ),
                    ]))),
        Container(
          width: 400.0,
          height: double.maxFinite,
          decoration:
              BoxDecoration(border: Border(left: BorderSide(color: outlineVariant))),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              SliverToBoxAdapter(child: content.title),
              SliverList.builder(
                  itemCount: content.itemCount,
                  itemBuilder: content.itemBuilder)
            ],
          ),
        ),
      ],
    );
  }
}
