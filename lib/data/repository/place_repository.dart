import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:yeohaeng_ttukttak_v3/data/dto/place_list_response.dart';

class PlaceRepository {
  final String baseUrl;

  PlaceRepository({required this.baseUrl});

  Future<PlaceListResponse> getPlacesByRegionCode({
    required String regionCode,
  }) async {
    final Response response = await get(
        Uri.https(baseUrl, '/api/v3/places', {'regionCode': regionCode}));

    return PlaceListResponse.fromJson(utf8.decode(response.bodyBytes));
  }
}

final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  return PlaceRepository(baseUrl: 'yeohaeng-ttukttak.com');
});