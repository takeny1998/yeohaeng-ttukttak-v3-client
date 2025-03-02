import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/dto/place_list_response.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/place_repository.dart';
import 'package:yeohaeng_ttukttak_v3/model/place.dart';

class SampleProvider extends AsyncNotifier<List<Place>> {
  @override
  FutureOr<List<Place>> build() async {
    final PlaceRepository repository = ref.watch(placeRepositoryProvider);
    final PlaceListResponse response =
        await repository.getPlacesByRegionCode(regionCode: '4311100000');

    return response.places;
  }
}

final sampleProvider = AsyncNotifierProvider<SampleProvider, List<Place>>(SampleProvider.new);