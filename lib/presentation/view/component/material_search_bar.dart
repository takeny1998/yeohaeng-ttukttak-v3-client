import 'package:flutter/material.dart';

class MaterialSearchBar extends StatelessWidget {

  final String? hintText;

  final WidgetStateProperty<BorderSide>? borderSide;
  final WidgetStateProperty<Color>? backgroundColor;

  const MaterialSearchBar({super.key, this.hintText, this.borderSide, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final ColorScheme(:onSurfaceVariant) = Theme.of(context).colorScheme;
    return SearchBar(
      elevation: const WidgetStatePropertyAll(0.0),
      side: borderSide,
      hintText: hintText,
      constraints: const BoxConstraints(
        minWidth: 360.0,
        maxWidth: 720.0,
        minHeight: 56.0,
        maxHeight: 56.0,
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: onSurfaceVariant),
        onPressed: () {},
      ),
      trailing: [
        IconButton(
          icon: Icon(Icons.search, color: onSurfaceVariant),
          onPressed: () {},
        )
      ],
    );
  }
}
