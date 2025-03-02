
import 'package:go_router/go_router.dart';
import 'package:yeohaeng_ttukttak_v3/view/home/home_page.dart';
import 'package:yeohaeng_ttukttak_v3/view/sample/sample_page.dart';

final goRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (_, __) => const HomePage()),
  GoRoute(path: '/sample', builder: (_, __) => const SamplePage())
]);