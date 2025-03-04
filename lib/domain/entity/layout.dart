import 'package:equatable/equatable.dart';

class Layout extends Equatable {
  final double minWidth;
  final double maxWidth;

  const Layout({
    required this.minWidth,
    required this.maxWidth,
  });

  bool operator >(Layout other) => minWidth.compareTo(other.minWidth) > 0;
  bool operator <(Layout other) => minWidth.compareTo(other.minWidth) < 0;
  bool operator >=(Layout other) => minWidth.compareTo(other.minWidth) >= 0;
  bool operator <=(Layout other) => minWidth.compareTo(other.minWidth) <= 0;
  
  @override
  List<Object?> get props => [minWidth, maxWidth];

}
