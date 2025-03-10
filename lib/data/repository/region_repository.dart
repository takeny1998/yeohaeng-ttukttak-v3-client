import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import 'package:yeohaeng_ttukttak_v3/data/repository/response/region_response.dart';

class RegionRepository {
  final String baseUrl;

  const RegionRepository({
    required this.baseUrl,
  });

  Future<RegionResponse> findByCoords(
      final double longitude, final double latitude,
      {int level = 2}) async {
    final response = await get(Uri.https(
      baseUrl,
      '/api/v3/regions',
      {
        'level': level.toString(),
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
      },
    ));

    return RegionResponse.fromJson(utf8.decode(response.bodyBytes));
  }
}

final regionRepositoryProvider = Provider<RegionRepository>((ref) {
  return const RegionRepository(baseUrl: 'yeohaeng-ttukttak.com');
});
