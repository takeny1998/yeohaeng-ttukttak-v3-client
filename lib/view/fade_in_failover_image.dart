import 'package:flutter/material.dart';

import 'package:yeohaeng_ttukttak_v3/dto/image_dto.dart';

class FadeInFailoverImage extends StatelessWidget {
  final ImageDto image;

  const FadeInFailoverImage({
    super.key,
    required this.image,
  });

  static const String placeholderPath = 'images/placeholder.jpeg';

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        image: image.url,
        placeholder: placeholderPath,
        imageErrorBuilder: (_, __, ___) =>
            Image.asset(placeholderPath, fit: BoxFit.cover));
  }
}
