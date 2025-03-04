import 'package:yeohaeng_ttukttak_v3/domain/entity/layout.dart';

enum MaterialLayout {
  compact(Layout(minWidth: 0, maxWidth: 600)),
  medium(Layout(minWidth: 600, maxWidth: 840)),
  expanded(Layout(minWidth: 840, maxWidth: 1200)),
  large(Layout(minWidth: 1200, maxWidth: 1600)),
  extraLarge(Layout(maxWidth: 1600, minWidth: double.infinity));

  final Layout layout;

  const MaterialLayout(this.layout);

  static MaterialLayout fromWidth(double width) {
    return MaterialLayout.values.firstWhere(
      (layout) =>
          layout.layout.minWidth <= width && width < layout.layout.maxWidth,
      orElse: () => MaterialLayout.extraLarge,
    );
  }
}
