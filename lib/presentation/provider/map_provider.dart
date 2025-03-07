import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/region_repository.dart';
import 'package:yeohaeng_ttukttak_v3/data/repository/response/region_response.dart';

final tileUrlProvider = Provider<String>((ref) {
  return 'https://yeohaeng-ttukttak.com/map/styles/basic/512/{z}/{x}/{y}.png';
});

class MapLocation extends Equatable {
  final double longitude;

  final double latitude;

  final double zoom;

  final RegionModel region;

  const MapLocation({
    required this.longitude,
    required this.latitude,
    required this.zoom,
    required this.region,
  });

  MapLocation copyWith({
    double? longitude,
    double? latitude,
    double? zoom,
    RegionModel? region,
  }) {
    return MapLocation(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      zoom: zoom ?? this.zoom,
      region: region ?? this.region,
    );
  }

  @override
  List<Object> get props => [longitude, latitude, zoom, region];

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'zoom': zoom,
      'region': region.toMap(),
    };
  }

  factory MapLocation.fromMap(Map<String, dynamic> map) {
    return MapLocation(
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      zoom: map['zoom']?.toDouble() ?? 0.0,
      region: RegionModel.fromMap(map['region']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapLocation.fromJson(String source) =>
      MapLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MapLocation(longitude: $longitude, latitude: $latitude, zoom: $zoom, region: $region)';
  }
}

class MapLocationNotifier extends Notifier<MapLocation> {
  Timer? _timer;

  @override
  MapLocation build() {
    print('build MapLocationProvider');

    ref.onDispose(_disposeTimer);
    return const MapLocation(
        longitude: 127.492913,
        latitude: 36.621087,
        zoom: 15.0,
        region: RegionModel(code: '4311100000', name: '청주시 상당구, 충청북도'));
  }

  void updateMapState(
      {required double longitude,
      required double latitude,
      required double zoom}) {
    if (_timer != null) {
      _disposeTimer();
    }

    _startTimer(() =>
        _updateLocation(longitude: longitude, latitude: latitude, zoom: zoom));
  }

  Future<void> _updateLocation(
      {required double longitude,
      required double latitude,
      required double zoom}) async {
    final RegionResponse regionResponse = await ref
        .read(regionRepositoryProvider)
        .findByCoords(longitude, latitude);

    state = state.copyWith(
      region: regionResponse.region,
      longitude: longitude,
      latitude: latitude,
      zoom: zoom,
    );
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