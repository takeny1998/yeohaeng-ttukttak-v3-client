
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/place_repository.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/response/place_list_response.dart';

final regionPlaceListProvider =
    FutureProvider.family<List<PlaceModel>, RegionModel>((ref, region) async {
  final PlaceRepository repository = ref.watch(placeRepositoryProvider);

  final PlaceListResponse response =
      await repository.getPlacesByRegionCode(regionCode: region.code);

  return response.places;
});


