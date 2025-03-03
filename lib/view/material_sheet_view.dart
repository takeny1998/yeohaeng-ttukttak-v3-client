import 'package:flutter/material.dart';

typedef MaterialSheetHeaderBuilder = Widget Function(
  bool isBottomSheetExpanded, bool isBottomSheetScolled,
);

class MaterialSheetListContent {

  final Widget title;

  final int itemCount;

  final Widget Function(BuildContext context, int index) itemBuilder;

  MaterialSheetListContent({required this.title, required this.itemCount, required this.itemBuilder});

}

typedef MaterialSheetBackgroundBuilder = Widget Function(
  double bottomSheetHeight,
);

abstract interface class MaterialSheetView {
  final MaterialSheetHeaderBuilder headerBuilder;

  final MaterialSheetListContent content;

  final MaterialSheetBackgroundBuilder backgroundBuilder;

  MaterialSheetView({
    required this.headerBuilder,
    required this.content,
    required this.backgroundBuilder,
  });
}
