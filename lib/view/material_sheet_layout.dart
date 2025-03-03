import 'package:flutter/material.dart';

typedef MaterialSheetHeaderBuilder = Widget Function(
  bool isBottomSheetExpanded, bool isBottomSheetScolled,
);

class MaterialSheetHeader {

  final Widget Function(bool isBottomSheetExpanded) headerBuilder;
  
  final Widget appBar;

  MaterialSheetHeader({required this.headerBuilder, required this.appBar});

}

class MaterialSheetContent  {

  final Widget title;

  final int itemCount;

  final Widget Function(BuildContext context, int index) itemBuilder;

  MaterialSheetContent({required this.title, required this.itemCount, required this.itemBuilder});

}

typedef MaterialSheetBackgroundBuilder = Widget Function(
  double bottomSheetHeight,
);

abstract interface class MaterialSheetLayout {

  final MaterialSheetHeader header;
  final MaterialSheetContent content;
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  final bool isLoading;

  MaterialSheetLayout({
    required this.header,
    required this.content,
    required this.backgroundBuilder,
    required this.isLoading,
  });
}
