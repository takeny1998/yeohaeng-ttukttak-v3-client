import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/view/sheet_layout.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetLayout(
        background: Container(color: Colors.blue),
        sheet: Column(
          children: [
            for (int i = 0; i < 24; i++) ...[
              Container(
                  width: double.maxFinite, height: 120.0, color: Colors.red),
              Container(
                  width: double.maxFinite, height: 120.0, color: Colors.green),
            ]
          ],
        ));
  }
}
