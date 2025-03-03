import 'package:equatable/equatable.dart';

class ImageDto extends Equatable {

  final int id;

  final String url;

  const ImageDto({
    required this.id,
    required this.url,
  });

  ImageDto copyWith({
    int? id,
    String? url,
  }) {
    return ImageDto(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }
  
  @override
  String toString() => 'ImageDto(id: $id, url: $url)';

  @override
  List<Object> get props => [id, url];
}
