
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';

class RegionResponse extends Equatable {

  final String message;

  final RegionModel region;
  
  const RegionResponse({
    required this.message,
    required this.region,
  });


  RegionResponse copyWith({
    String? message,
    RegionModel? region,
  }) {
    return RegionResponse(
      message: message ?? this.message,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'region': region.toMap(),
    };
  }

  factory RegionResponse.fromMap(Map<String, dynamic> map) {
    return RegionResponse(
      message: map['message'] ?? '',
      region: RegionModel.fromMap(map['region']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionResponse.fromJson(String source) => RegionResponse.fromMap(json.decode(source));

  @override
  String toString() => 'RegionResponse(message: $message, region: $region)';

  @override
  List<Object> get props => [message, region];
}
