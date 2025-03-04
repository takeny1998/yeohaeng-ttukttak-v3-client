import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/map_marker_dto.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/map_provider.dart';
import 'package:latlong2/latlong.dart';

class MapLayout extends ConsumerStatefulWidget {
  const MapLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapLayoutState();
}

class _MapLayoutState extends ConsumerState<MapLayout> {
  final MapController mapController = MapController();

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Marker buildMarker(MapMarkerDto dto) {
    return Marker(
      width: 18.0,
      height: 18.0,
      point: LatLng(dto.latitude, dto.longitude),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFF79747E),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 1.0),
        ),
        child: const Center(
            child: Icon(Icons.location_on, color: Colors.white, size: 10.0)),
      ),
    );
  }

  Marker buildLabel(MapMarkerDto dto) {
    final Text text = Text(
      dto.name,
      style: const TextStyle(
        fontSize: 14.0,
        color: Color(0XFF49454F),
      ),
    );

    return Marker(
      width: 160.0,
      height: 28.0,
      point: LatLng(dto.latitude, dto.longitude),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(top: 9.0),
        constraints: const BoxConstraints(maxWidth: 160.0),
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Text(text.data!,
                textScaler: text.textScaler,
                style: text.style?.copyWith(
                    foreground: Paint()
                      ..color = Colors.white
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2.0)),
            text,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tileUrl = ref.watch(tileUrlProvider);
    final markers = ref.watch(mapMarkerProvider);
    final initialLocation = ref.read(mapLocationProvider);

    ref.listen(mapMarkerProvider, (prev, next) {
      if (prev == next) return;

      final coordinates =
          next.map((dto) => LatLng(dto.latitude, dto.longitude)).toList();

      mapController.fitCamera(CameraFit.coordinates(coordinates: coordinates));
    });

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          initialCenter:
              LatLng(initialLocation.latitude, initialLocation.longitude),
          initialZoom: initialLocation.zoom,
          keepAlive: true,
          onPositionChanged: (camera, hasGesture) => ref
              .read(mapLocationProvider.notifier)
              .updateMapState(
                  longitude: camera.center.longitude,
                  latitude: camera.center.latitude,
                  zoom: camera.zoom)),
      children: [
        TileLayer(
            urlTemplate: tileUrl,
            tileProvider: CancellableNetworkTileProvider()),
        MarkerLayer(markers: markers.map((dto) => buildMarker(dto)).toList()),
        MarkerLayer(markers: markers.map((dto) => buildLabel(dto)).toList()),
      ],
    );
  }
}
