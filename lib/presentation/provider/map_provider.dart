import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tileUrlProvider = Provider<String>((ref) {
  return 'https://yeohaeng-ttukttak.com/map/styles/basic/512/{z}/{x}/{y}.png';
});


class MapState extends Equatable {

  final double longitude;

  final double latitude;

  final double zoom;

  const MapState({
    required this.longitude,
    required this.latitude,
    required this.zoom,
  });

  MapState copyWith({
    double? longitude,
    double? latitude,
    double? zoom,
  }) {
    return MapState(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      zoom: zoom ?? this.zoom,
    );
  }

  @override
  List<Object> get props => [longitude, latitude, zoom];
}

class MapStateNotifier extends Notifier<MapState> {
  
  @override
  MapState build() {
    return const MapState(longitude: 126.9780, latitude: 37.5665, zoom: 15.0);
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

final mapStateProvider = NotifierProvider<MapStateNotifier, MapState>(MapStateNotifier.new);