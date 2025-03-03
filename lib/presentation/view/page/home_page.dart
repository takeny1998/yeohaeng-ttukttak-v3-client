import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('여행뚝딱'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            TextButton(
                onPressed: () => GoRouter.of(context).push('/sample'),
                child: const Text('Sample Page')),
            TextButton(
                onPressed: () => GoRouter.of(context).push('/explore'),
                child: const Text('Explore Page')), 
          ]),
        ));
  }
}
