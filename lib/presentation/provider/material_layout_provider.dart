import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/domain/entity/material_layout.dart';

class MaterialLayoutProvider extends Notifier<MaterialLayout> {
  @override
  MaterialLayout build() {
    return MaterialLayout.compact;
  }

  void updateLayout(double width) {
    state = MaterialLayout.fromWidth(width);
  }
}

final materialLayoutProvider =
    NotifierProvider<MaterialLayoutProvider, MaterialLayout>(
        MaterialLayoutProvider.new);
