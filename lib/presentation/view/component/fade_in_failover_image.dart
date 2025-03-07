import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/image_model.dart';
import 'package:yeohaeng_ttukttak_v3/domain/service/image_url_service.dart';

class FadeInFailoverImage extends ConsumerWidget {
  final ImageModel image;

  const FadeInFailoverImage({
    super.key,
    required this.image,
  });

  static const String placeholderPath = 'images/placeholder.jpeg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final ImageUrlService imageUrlService = ref.watch(imageUrlServiceProvider);


    return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        image: imageUrlService.getUrl(image, width: 256, height: 144),
        placeholder: placeholderPath,
        imageErrorBuilder: (_, __, ___) =>
            Image.asset(placeholderPath, fit: BoxFit.cover));
  }
}
