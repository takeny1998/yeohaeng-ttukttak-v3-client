import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/place_model.dart';
import 'package:yeohaeng_ttukttak_v3/data/model/region_model.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/map_region_provider.dart';
import 'package:yeohaeng_ttukttak_v3/presentation/provider/region_place_list_provider.dart';
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

    final AsyncValue<RegionModel> regionState = ref.watch(mapRegionProvider);

    return Scaffold(
      body: MaterialResponsiveSheetLayout(
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
                      Theme(
                        data: Theme.of(context).copyWith(
                            chipTheme: ChipThemeData(
                                backgroundColor: surfaceContainerLow)),
                        child: SingleChildScrollView(
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
                                  avatar:
                                      const Icon(Icons.local_activity_outlined),
                                  onSelected: (isSelected) {}),
                              FilterChip(
                                  label: const Text('Cost'),
                                  avatar:
                                      const Icon(Icons.attach_money_outlined),
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
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                );
              },
              appBar: AppBar(
                title: const Text(''),
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
          title: const SizedBox(),
          content: regionState.when(
              data: (region) {
                final List<PlaceModel> places = ref
                        .watch(regionPlaceListProvider(region))
                        .whenOrNull(data: (data) => data) ??
                    [];

                return SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(direction: Axis.vertical, children: [
                        Text(region.name, style: titleLarge),
                        Text('${places.length}개 결과',
                            style:
                                bodyMedium?.copyWith(color: onSurfaceVariant)),
                        const SizedBox(height: 16.0),
                      ]),
                    )),
                    SliverList.separated(
                        itemCount: places.length,
                        key: ValueKey(region.code),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: PlaceCard(place: places[index]));
                        },
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 24.0)),
                  ],
                );
              },
              error: (error, st) {
                debugPrintStack(stackTrace: st);
                return SliverToBoxAdapter(
                    child: Center(child: Text(error.toString())));
              },
              loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()))),
          background: const MapLayout()),
    );
  }
}
