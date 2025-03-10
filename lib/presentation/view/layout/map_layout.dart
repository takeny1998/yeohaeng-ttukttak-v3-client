import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/map_provider.dart';

class MapLayout extends ConsumerStatefulWidget {
  final List<PlaceModel> places;
  const MapLayout({super.key, required this.places});

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

  Marker buildMarker(PlaceModel place) {
    return Marker(
      width: 18.0,
      height: 18.0,
      point: LatLng(place.latitude, place.longitude),
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

  Marker buildLabel(PlaceModel place) {
    final Text text = Text(
      place.name,
      style: const TextStyle(
        fontSize: 14.0,
        color: Color(0XFF49454F),
      ),
    );

    return Marker(
      width: 160.0,
      height: 28.0,
      point: LatLng(place.latitude, place.longitude),
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
    final places = widget.places;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(36.621087, 127.492913),
        initialZoom: 15.0,
        interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom),
        keepAlive: true,
        onPointerUp: (event, point) {
          final LatLng center = mapController.camera.center;
          ref
              .read(mapRegionProvider.notifier)
              .updateRegion(center.longitude, center.latitude);
        },
      ),
      children: [
        TileLayer(
            urlTemplate: tileUrl,
            tileProvider: CancellableNetworkTileProvider()),
        MarkerLayer(markers: places.map((dto) => buildMarker(dto)).toList()),
        MarkerLayer(markers: places.map((dto) => buildLabel(dto)).toList()),
      ],
    );
  }
}
