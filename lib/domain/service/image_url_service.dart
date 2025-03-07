import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/image_model.dart';

abstract interface class ImageUrlService {

  String getUrl(ImageModel image, { required int width, required int height });

}
class PicksumUrlService implements ImageUrlService {
  
  @override
  String getUrl(final ImageModel image,  { required int width, required int height }) {
    return Uri(
      scheme: 'https',
      host: 'picsum.photos',
      path: '/id/${image.id}/$width/$height'
    ).toString();
  }

}

final imageUrlServiceProvider = Provider<ImageUrlService>((ref) {
  return PicksumUrlService();
});