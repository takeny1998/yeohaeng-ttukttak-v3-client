import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/response/place_list_response.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/place_repository.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';

class SampleProvider extends AsyncNotifier<List<PlaceModel>> {
  @override
  FutureOr<List<PlaceModel>> build() async {
    final PlaceRepository repository = ref.watch(placeRepositoryProvider);
    final PlaceListResponse response =
        await repository.getPlacesByRegionCode(regionCode: '4311100000');

    return response.places;
  }
}

final sampleProvider = AsyncNotifierProvider<SampleProvider, List<PlaceModel>>(SampleProvider.new);