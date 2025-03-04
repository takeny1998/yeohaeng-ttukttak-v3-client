import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/image_dto.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/dto/place_dto.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/explore_provider.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/component/place_card.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/component/material_search_bar.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/map_layout.dart';
import 'package:yeohaeng_ttukttak_v3/domain/entity/material_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/view/layout/material_responsive_sheet_layout.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme(
      :outlineVariant,
      :surfaceContainerLow,
      :surfaceContainer,
      :onSurfaceVariant
    ) = Theme.of(context).colorScheme;

    final TextTheme(:titleLarge, :bodyMedium) = Theme.of(context).textTheme;

    final asyncState = ref.watch(exploreProvider);

    final List<PlaceDto> places = asyncState.whenOrNull(
            data: (places) => places) ??
        List.generate(
            10,
            (index) => PlaceDto(
                id: index + 1,
                name: BoneMock.name,
                address: BoneMock.address,
                longitude: 0.0,
                latitude: 0.0,
                rating: 4.5,
                visitCount: 12,
                images: List.generate(
                    5, (index) => ImageDto(id: index + 1, url: '')).toList()));

    const String title = 'Cheongju-si';
    String subtitle = '${places.length} Attractions';

    final Widget titleWidget = Row(
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(title, style: titleLarge),
            Text(subtitle, style: bodyMedium?.copyWith(color: onSurfaceVariant))
          ],
        ),
      ],
    );

    return Scaffold(
      body: MaterialResponsiveSheetLayout(
        isLoading: asyncState.isLoading,
        header: MaterialSheetHeader(
            headerBuilder: (isBottomSheetExpanded) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                      child: MaterialSearchBar(
                        hintText: 'Search places to go',
                        borderSide: !isBottomSheetExpanded
                            ? WidgetStatePropertyAll(
                                BorderSide(color: outlineVariant))
                            : null,
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8.0,
                        children: [
                          FilterChip(
                              label: const Text('Date'),
                              avatar: const Icon(Icons.today_outlined),
                              onSelected: (isSelected) {}),
                          FilterChip(
                              label: const Text('Activity'),
                              avatar: const Icon(Icons.local_activity_outlined),
                              onSelected: (isSelected) {}),
                          FilterChip(
                              label: const Text('Cost'),
                              avatar: const Icon(Icons.attach_money_outlined),
                              onSelected: (isSelected) {}),
                          FilterChip(
                              label: const Text('Companion'),
                              avatar: const Icon(Icons.people_outline),
                              onSelected: (isSelected) {}),
                          FilterChip(
                              label: const Text('Transport'),
                              avatar: const Icon(Icons.local_taxi_outlined),
                              onSelected: (isSelected) {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            },
            appBar: AppBar(
              title: const Text(title),
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              centerTitle: false,
              actions: [
                Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)))
              ],
            )),
        content: MaterialSheetContent(
            title: titleWidget,
            itemCount: places.length,
            itemBuilder: (context, index) => PlaceCard(place: places[index])),
        background: const MapLayout()
      ),
    );
  }
}
