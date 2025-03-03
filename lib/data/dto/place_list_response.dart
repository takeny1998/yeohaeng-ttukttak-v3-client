
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:yeohaeng_ttukttak_v3/model/place_model.dart';

class PlaceListResponse extends Equatable {

  final String message;

  final List<PlaceModel> places;
  
  const PlaceListResponse({
    required this.message,
    required this.places,
  });


  PlaceListResponse copyWith({
    String? message,
    List<PlaceModel>? places,
  }) {
    return PlaceListResponse(
      message: message ?? this.message,
      places: places ?? this.places,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'places': places.map((x) => x.toMap()).toList(),
    };
  }

  factory PlaceListResponse.fromMap(Map<String, dynamic> map) {
    return PlaceListResponse(
      message: map['message'] ?? '',
      places: List<PlaceModel>.from(map['places']?.map((x) => PlaceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceListResponse.fromJson(String source) => PlaceListResponse.fromMap(json.decode(source));

  @override
  String toString() => 'PlaceListResponse(message: $message, places: $places)';

  @override
  List<Object> get props => [message, places];
}
