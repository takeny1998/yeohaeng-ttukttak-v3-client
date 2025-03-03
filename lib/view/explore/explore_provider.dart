import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/dto/place_list_response.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/place_repository.dart';
import 'package:yeohaeng_ttukttak_v3/model/place_model.dart';

class ExploreProvider extends AsyncNotifier<List<PlaceModel>> {
  @override
  FutureOr<List<PlaceModel>> build() async {
    final PlaceRepository repository = ref.watch(placeRepositoryProvider);
    final PlaceListResponse response =
        await repository.getPlacesByRegionCode(regionCode: '4311100000');

    await Future.delayed(const Duration(seconds: 3));

    return response.places;
  }
}

final exploreProvider = AsyncNotifierProvider<ExploreProvider, List<PlaceModel>>(ExploreProvider.new);