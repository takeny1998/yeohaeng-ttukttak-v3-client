import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';

class MapPlaceListNotifier extends Notifier<List<PlaceModel>> {
  @override
  List<PlaceModel> build() {
    return [];
  }

  void updatePlaces(List<PlaceModel> places) {
    state = places;
  }
}

final mapPlaceListProvider = NotifierProvider<MapPlaceListNotifier, List<PlaceModel>>(
    MapPlaceListNotifier.new);
