import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_search_bar.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_sheet_layout.dart';
import 'package:yeohaeng_ttukttak_v3/view/sheet_layout.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String title = 'Cheongju-si';
    const String subtitle = '12 Attractions';

    final ColorScheme(
      :outlineVariant,
      :surfaceContainerLow,
      :surfaceContainer,
      :onSurfaceVariant
    ) = Theme.of(context).colorScheme;

    final TextTheme(:titleLarge, :bodyMedium) = Theme.of(context).textTheme;

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
        content: MaterialSheetListContent(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
              child: Row(
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(title, style: titleLarge),
                      Text(subtitle,
                          style: bodyMedium?.copyWith(color: onSurfaceVariant))
                    ],
                  ),
                ],
              ),
            ),
            itemCount: 24,
            itemBuilder: (context, index) => Container(
                width: double.maxFinite,
                height: 120.0,
                color: index % 2 == 0 ? Colors.red : Colors.green)),
        backgroundBuilder: (double bottomSheetHeight) {
          return Container(color: Colors.white60);
        },
      ),
    );
  }
}
