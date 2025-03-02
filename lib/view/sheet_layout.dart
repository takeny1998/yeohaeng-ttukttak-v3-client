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

      final bool hasSideSheet = maxWidth >= 840;

      return Scaffold(
          appBar: AppBar(),
          body: Row(
            children: [
              Expanded(child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                background,

                if (!hasSideSheet)
                  MaterialBottomSheet(                    child: sheet)
              ])),



              if (hasSideSheet)
                Container(
                  width: 400.0,
                  height: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                  child: sheet,
                )
            ],
          ));
    });
  }
}
