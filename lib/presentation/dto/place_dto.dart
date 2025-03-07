import 'package:equatable/equatable.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/image_dto.dart';

class PlaceDto extends Equatable {

  final int id;

  final String name;

  final RegionModel region;

  final double longitude;

  final double latitude;

  final double rating;

  final int visitCount;

  final List<ImageDto> images;
  
  const PlaceDto({
    required this.id,
    required this.name,
    required this.region,
    required this.longitude,
    required this.latitude,
    required this.rating,
    required this.visitCount,
    required this.images,
  });



  PlaceDto copyWith({
    int? id,
    String? name,
    RegionModel? region,
    double? longitude,
    double? latitude,
    double? rating,
    int? visitCount,
    List<ImageDto>? images,
  }) {
    return PlaceDto(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      rating: rating ?? this.rating,
      visitCount: visitCount ?? this.visitCount,
      images: images ?? this.images,
    );
  }

  @override
  String toString() {
    return 'PlaceDto(id: $id, name: $name, region: $region, longitude: $longitude, latitude: $latitude, rating: $rating, visitCount: $visitCount, images: $images)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      region,
      longitude,
      latitude,
      rating,
      visitCount,
      images,
    ];
  }

}
