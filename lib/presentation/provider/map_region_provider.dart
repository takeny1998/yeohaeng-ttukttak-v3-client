import 'package:async/async.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/region_repository.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/response/region_response.dart';

final tileUrlProvider = Provider<String>((ref) {
  return 'https://yeohaeng-ttukttak.com/map/styles/basic/512/{z}/{x}/{y}.png';
});

class MapRegionNotifier extends AsyncNotifier<RegionModel> {
  CancelableOperation? _future;

  @override
  FutureOr<RegionModel> build() async {
    return const RegionModel(code: '4311100000', name: '청주시 상당구, 충청북도');
  }

  Future<void> updateRegion(double longitude, double latitude) async {
    if (_future != null) {
      _future?.cancel();
    }

    _future =
        CancelableOperation.fromFuture(_updateRegion(longitude, latitude), onCancel: () => print('Cancel'));
  }

  Future<void> _updateRegion(double longitude, double latitude) async {
    print('start');

    state = await AsyncValue.guard(() async {
      final RegionResponse response = await ref
          .read(regionRepositoryProvider)
          .findByCoords(longitude, latitude);

      return response.region;
    });

    print('completed');
  }
}

final mapRegionProvider = AsyncNotifierProvider<MapRegionNotifier, RegionModel>(
    MapRegionNotifier.new);
