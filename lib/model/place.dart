import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:yeohaeng_ttukttak_v3/model/image.dart';

class Place extends Equatable {

  final int id;

  final String name;

  final String regionCode;

  final double longitude;

  final double latitude;

  final double rating;

  final int visitCount;

  final List<Image> images;

  const Place({
    required this.id,
    required this.name,
    required this.regionCode,
    required this.longitude,
    required this.latitude,
    required this.rating,
    required this.visitCount,
    required this.images,
  });


  Place copyWith({
    int? id,
    String? name,
    String? regionCode,
    double? longitude,
    double? latitude,
    double? rating,
    int? visitCount,
    List<Image>? images,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      regionCode: regionCode ?? this.regionCode,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      rating: rating ?? this.rating,
      visitCount: visitCount ?? this.visitCount,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'regionCode': regionCode,
      'longitude': longitude,
      'latitude': latitude,
      'rating': rating,
      'visitCount': visitCount,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      regionCode: map['regionCode'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      visitCount: map['visitCount']?.toInt() ?? 0,
      images: List<Image>.from(map['images']?.map((x) => Image.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(id: $id, name: $name, regionCode: $regionCode, longitude: $longitude, latitude: $latitude, rating: $rating, visitCount: $visitCount, images: $images)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      regionCode,
      longitude,
      latitude,
      rating,
      visitCount,
      images,
    ];
  }
}
