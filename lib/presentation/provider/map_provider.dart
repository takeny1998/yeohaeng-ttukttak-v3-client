import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeohaeng_ttukttak_v3/presentation/dto/map_marker_dto.dart';

final tileUrlProvider = Provider<String>((ref) {
  return 'https://yeohaeng-ttukttak.com/map/styles/basic/512/{z}/{x}/{y}.png';
});


class MapLocation extends Equatable {

  final double longitude;

  final double latitude;

  final double zoom;

  const MapLocation({
    required this.longitude,
    required this.latitude,
    required this.zoom,
  });

  MapLocation copyWith({
    double? longitude,
    double? latitude,
    double? zoom,
  }) {
    return MapLocation(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      zoom: zoom ?? this.zoom,
    );
  }

  @override
  List<Object> get props => [longitude, latitude, zoom];
}

class MapLocationNotifier extends Notifier<MapLocation> {
  
  @override
  MapLocation build() {
    return const MapLocation(longitude: 126.9780, latitude: 37.5665, zoom: 15.0,);
  }

  void updateMapState({
    double? longitude,
    double? latitude,
    double? zoom,
  }) {
    state = state.copyWith(
      longitude: longitude,
      latitude: latitude,
      zoom: zoom,
    );
  }


}

class MapMarkerProvider extends Notifier<List<MapMarkerDto>> {
  @override
  List<MapMarkerDto> build() {
    return [];
  }
  void updateMarkers(List<MapMarkerDto> markers) {
    state = markers;
  }
}

final mapLocationProvider = NotifierProvider<MapLocationNotifier, MapLocation>(MapLocationNotifier.new);

final mapMarkerProvider = NotifierProvider<MapMarkerProvider, List<MapMarkerDto>>(MapMarkerProvider.new);