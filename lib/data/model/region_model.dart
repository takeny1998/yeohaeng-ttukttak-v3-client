import 'dart:convert';

import 'package:equatable/equatable.dart';


class RegionModel extends Equatable {

  final String code;

  final String name;
  
  const RegionModel({
    required this.code,
    required this.name,
  });


  RegionModel copyWith({
    String? code,
    String? name,
  }) {
    return RegionModel(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) => RegionModel.fromMap(json.decode(source));

  @override
  String toString() => 'RegionModel(code: $code, name: $name)';

  @override
  List<Object> get props => [code, name];
}
