import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/image_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/component/material_carosel.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/component/fade_in_failover_image.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final ColorScheme(
      :primary,
      :outlineVariant,
      :surfaceContainer,
      :surfaceContainerHighest,
      :onSurfaceVariant,
      :surface,
      :surfaceBright,
    ) = Theme.of(context).colorScheme;

    final TextTheme(:titleMedium, :bodyMedium) = Theme.of(context).textTheme;

    final TextStyle? subtitleTextStyle =
        bodyMedium?.copyWith(color: onSurfaceVariant);

    return Card.outlined(
        child: Column(children: [
      const SizedBox(height: 16.0),
      Container(
          height: 180.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: MaterialCarosel(
            children: [
              for (final ImageModel image in place.images)
              FadeInFailoverImage(image: image)
            ],
          )),
      ListTile(
          titleTextStyle: titleMedium?.copyWith(fontWeight: FontWeight.bold),
          subtitleTextStyle: subtitleTextStyle,
          title: Text(place.name),
          subtitle: Text(place.region.name),
          trailing: IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
              color: primary)),
      Row(children: [
        const SizedBox(width: 16.0),
        Icon(Icons.star_rate, size: 16.0, color: primary),
        Text(' ${place.rating.toStringAsFixed(1)}(${place.visitCount})',
            style: subtitleTextStyle),
        const SizedBox(width: 16.0),
      ]),
      const SizedBox(height: 16.0),
    ]));
  }
}
