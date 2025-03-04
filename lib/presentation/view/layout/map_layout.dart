import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    final tileUrl = ref.watch(tileUrlProvider);

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(37.5665, 126.9780),
        initialZoom: 13.0,
        keepAlive: true,
        onPositionChanged: (camera, hasGesture) => ref
            .read(mapStateProvider.notifier)
            .updateMapState(
                longitude: camera.center.longitude,
                latitude: camera.center.latitude,
                zoom: camera.zoom)),
      children: [
        TileLayer(
            urlTemplate: tileUrl,
            tileProvider: CancellableNetworkTileProvider())
      ],
    );
  }
}
