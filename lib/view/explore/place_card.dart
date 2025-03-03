import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yeohaeng_ttukttak_v3/model/image_model.dart';
import 'package:yeohaeng_ttukttak_v3/model/place_model.dart';

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

    return Card.outlined(
        child: Column(children: [
      const SizedBox(height: 16.0),
      Container(
          height: 180.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CarouselView.weighted(
            itemSnapping: true,
            flexWeights: const [8, 2],
            children: [
              for (final ImageModel image in place.images)
                Skeleton.replace(child: Container(color: surfaceContainer))
            ],
          )),
      ListTile(
          isThreeLine: true,
          title: Text(place.name),
          subtitle: Text(place.regionCode,
              style: bodyMedium?.copyWith(color: onSurfaceVariant)),
          trailing: IconButton.filledTonal(
              onPressed: () {}, icon: const Icon(Icons.bookmark_outlined))),
      Row(children: [
        const SizedBox(width: 16.0),
        Icon(Icons.star_rate, size: 16.0, color: primary),
        Text(' ${place.rating.toStringAsFixed(1)}(${place.visitCount})',
            style: bodyMedium?.copyWith(color: onSurfaceVariant)),
        const SizedBox(width: 16.0),
      ]),
      const SizedBox(height: 16.0),
    ]));
  }
}
