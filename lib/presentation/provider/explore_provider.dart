import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/dto/place_list_response.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/place_repository.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/image_dto.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/place_dto.dart';
import 'package:yeohaeng_ttukttak_v3/domain/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/domain/service/image_url_service.dart';

class ExploreProvider extends AsyncNotifier<List<PlaceDto>> {
  late final ImageUrlService _imageUrlService;

  @override
  FutureOr<List<PlaceDto>> build() async {
    final PlaceRepository repository = ref.watch(placeRepositoryProvider);
    final PlaceListResponse response =
        await repository.getPlacesByRegionCode(regionCode: '4311100000');

    _imageUrlService = ref.watch(imageUrlServiceProvider);

    await Future.delayed(const Duration(seconds: 3));

    return response.places.map((place) => _convertToDto(place)).toList();
  }

  PlaceDto _convertToDto(PlaceModel place) => PlaceDto(
        id: place.id,
        name: place.name,
        address: place.regionCode,
        longitude: place.longitude,
        latitude: place.latitude,
        rating: place.rating,
        visitCount: place.visitCount,
        images: place.images
            .map((image) => ImageDto(
                id: image.id,
                url: _imageUrlService.getUrl(image, width: 854, height: 480)))
            .toList(),
      );
}

final exploreProvider =
    AsyncNotifierProvider<ExploreProvider, List<PlaceDto>>(ExploreProvider.new);
