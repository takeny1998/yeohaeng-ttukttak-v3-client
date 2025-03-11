import 'package:flutter/material.dart';

typedef MaterialSheetHeaderBuilder = Widget Function(
  bool isBottomSheetExpanded, bool isBottomSheetScolled,
);

class MaterialSheetHeader {

  final Widget Function(bool isBottomSheetExpanded) headerBuilder;
  
  final Widget appBar;

  MaterialSheetHeader({required this.headerBuilder, required this.appBar});
}

abstract interface class MaterialSheetLayout {

  final MaterialSheetHeader header;

  final Widget title;
  final Widget content;
  final Widget background;

  MaterialSheetLayout({
    required this.header,
    required this.title,
    required this.content,
    required this.background,
  });
}
