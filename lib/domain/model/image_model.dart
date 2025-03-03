import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {

  final int id;

  final String url;

  const ImageModel({
    required this.id,
    required this.url,
  });

  ImageModel copyWith({
    int? id,
    String? url,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id']?.toInt() ?? 0,
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source));

  @override
  String toString() => 'ImageModel(id: $id, url: $url)';

  @override
  List<Object> get props => [id, url];
}
