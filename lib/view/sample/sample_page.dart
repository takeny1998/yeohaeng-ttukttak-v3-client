import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yeohaeng_ttukttak_v3/view/sample/sample_provider.dart';

class SamplePage extends ConsumerWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sampleState = ref.watch(sampleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sample')),
      body: sampleState.when(
          data: (places) => ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(places[index].name),
                    subtitle: Text(
                        '${places[index].rating} / ${places[index].regionCode}'),
                  )),
          error: (error, stackTrace) { 
            debugPrintStack(stackTrace: stackTrace);
            return Center(child: Text(error.toString()));
          },
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
