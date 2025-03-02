import 'dart:convert';

import 'package:equatable/equatable.dart';

class Image extends Equatable {

  final int id;

  final String url;
  const Image({
    required this.id,
    required this.url,
  });


  Image copyWith({
    int? id,
    String? url,
  }) {
    return Image(
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

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id']?.toInt() ?? 0,
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));

  @override
  String toString() => 'Image(id: $id, url: $url)';

  @override
  List<Object> get props => [id, url];
}
