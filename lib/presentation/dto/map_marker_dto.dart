
import 'package:equatable/equatable.dart';

class MapMarkerDto extends Equatable {

  final int id;

  final double longitude;

  final double latitude;

  final String name;

  final void Function() onTap;
  
  const MapMarkerDto({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.onTap,
  });


  @override
  String toString() {
    return 'MapMarkerDto(id: $id, longitude: $longitude, latitude: $latitude, name: $name, onTap: $onTap)';
  }

  @override
  List<Object> get props {
    return [
      id,
      longitude,
      latitude,
      name,
      onTap,
    ];
  }

}
