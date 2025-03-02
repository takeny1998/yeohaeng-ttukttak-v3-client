import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/view/sheet_layout.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetLayout(background: Container(color: Colors.blue), sheet: Container(
      width: double.maxFinite, height: double.maxFinite,
      color: Colors.red));
  }
}