import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  Timer? _timer;

  @override
  MapLocation build() {
    ref.onDispose(_disposeTimer);
    return const MapLocation(
      longitude: 126.9780,
      latitude: 37.5665,
      zoom: 15.0,
    );
  }

  void updateMapState({double? longitude, double? latitude, double? zoom}) {
    if (_timer != null) {
      _disposeTimer();
    }

    _startTimer(() => state = state.copyWith(
          longitude: longitude,
          latitude: latitude,
          zoom: zoom,
        ));
  }

  void _startTimer(VoidCallback callback) {
    _timer = Timer(const Duration(seconds: 2), () {
      _disposeTimer();
      callback.call();
    });
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }
}

final mapLocationProvider =
    NotifierProvider<MapLocationNotifier, MapLocation>(MapLocationNotifier.new);

class MapMarkerProvider extends Notifier<List<MapMarkerDto>> {
  @override
  List<MapMarkerDto> build() {
    print('MapMarkerProvider build');
    return [];
  }

  void updateMarkers(List<MapMarkerDto> markers) {
    state = markers;
  }
}

final mapMarkerProvider =
    NotifierProvider<MapMarkerProvider, List<MapMarkerDto>>(
        MapMarkerProvider.new);

class MapPaddingNotifier extends Notifier<EdgeInsets> {
  @override
  EdgeInsets build() {
    return EdgeInsets.zero;
  }
}

final mapPaddingProvider =
    NotifierProvider<MapPaddingNotifier, EdgeInsets>(MapPaddingNotifier.new);
