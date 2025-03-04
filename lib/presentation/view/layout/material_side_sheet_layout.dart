import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yeohaeng_ttukttak_v3/domain/entity/material_sheet_layout.dart';

class MaterialSideSheetLayout extends StatelessWidget
    implements MaterialSheetLayout {
  @override
  final MaterialSheetHeader header;
  @override
  final MaterialSheetContent content;
  @override
  final Widget background;
  @override
  final bool isLoading;

  const MaterialSideSheetLayout(
      {super.key,
      required this.header,
      required this.content,
      required this.background,
      required this.isLoading});

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
          child: Skeletonizer(
            enabled: isLoading,
            enableSwitchAnimation: true,
            switchAnimationConfig: const SwitchAnimationConfig(
              duration: Duration(milliseconds: 500),
            ),
            effect: ShimmerEffect(
              baseColor: surfaceContainer,
              highlightColor: surfaceContainerHighest,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 24.0, 24.0),
              children: [
                content.title,
                const SizedBox(height: 16.0),
                for (int i = 0; i < content.itemCount; i++) ...[
                  content.itemBuilder(context, i),
                  const SizedBox(height: 24.0),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
