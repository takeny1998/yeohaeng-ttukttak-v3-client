import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/map_place_list_provider.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/map_region_provider.dart';

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

  Marker buildMarker(PlaceModel place, int order) {
    final Text text = Text(
      place.name,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 12.0,
        overflow: TextOverflow.ellipsis,
        color: Color(0XFF49454F),
      ),
    );
    return Marker(
      width: 96.0,
      height: 62.0,
      key: ValueKey<int>(order),
      point: LatLng(place.latitude, place.longitude),
      child: SizedBox(
        child: Column(
          children: [
            Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: const Color(0XFF79747E),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white, width: 1.0),
                ),
                child: const Center(
                    child: Icon(Icons.location_on,
                        color: Colors.white, size: 10.0))),
            const SizedBox(height: 2.0),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(text.data!,
                    maxLines: text.maxLines,
                    textScaler: text.textScaler,
                    style: text.style?.copyWith(
                        foreground: Paint()
                          ..color = Colors.white
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2.0)),
                text,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCluster(PlaceModel place, int clusterCount) {
    final Text text = Text(
      place.name,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 12.0,
        overflow: TextOverflow.ellipsis,
        color: Color(0XFF49454F),
      ),
    );

    return SizedBox(
      child: Column(
        children: [
          Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: const Color(0XFF79747E),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Center(child: Text(clusterCount.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.0)))),
          const SizedBox(height: 2.0),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Text(text.data!,
                  maxLines: text.maxLines,
                  textScaler: text.textScaler,
                  style: text.style?.copyWith(
                      foreground: Paint()
                        ..color = Colors.white
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2.0)),
              text,
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tileUrl = ref.watch(tileUrlProvider);
    final places = ref.watch(mapPlaceListProvider);

    final markers =
        places.mapIndexed((index, dto) => buildMarker(dto, index)).toList();

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(36.621087, 127.492913),
        initialZoom: 15.0,
        interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom |
                InteractiveFlag.scrollWheelZoom),
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
        MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
                markers: markers,
                size: const Size(96.0, 68.0),
                maxClusterRadius: 128,
                builder: (context, markers) {
                  final marker = markers.reduce((a, b) {
                    final orderA = (a.key as ValueKey<int>).value;
                    final orderB = (b.key as ValueKey<int>).value;

                    if (orderA < orderB) return a;
                    return b;
                  });

                  return buildCluster(
                      places[(marker.key as ValueKey<int>).value],
                      markers.length);
                })),
      ],
    );
  }
}
