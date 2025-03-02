import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MaterialBottomSheet extends StatefulWidget {
  final Widget header;
  final Widget background;
  final Widget content;

  const MaterialBottomSheet(
      {super.key,
      required this.header,
      required this.background,
      required this.content});

  @override
  State<MaterialBottomSheet> createState() => _MaterialBottomSheetState();
}

class _MaterialBottomSheetState extends State<MaterialBottomSheet> {
  final ScrollController scrollController = ScrollController();

  final List<double> positions = [0.0, 0.5, 1.0];

  static const double maxWidth = 640.0;

  int index = 1;

  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme(:onSurfaceVariant, :surface) =
        Theme.of(context).colorScheme;

    final bool isFullyExpanded =
        index == (positions.length - 1) && !isAnimating;

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        widget.background,
        AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: isFullyExpanded ? surface : Colors.transparent),
        Column(
          children: [
            widget.header,
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final BoxConstraints(maxWidth: width, :maxHeight) = constraints;
                final EdgeInsets(:top) = MediaQuery.of(context).padding;
                final bool hasMaxWidth = width > maxWidth;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  AnimatedContainer(
                    onEnd: () async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      setState(() => isAnimating = false);
                    },
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    width: double.maxFinite,
                    height: (maxHeight - top) * positions[index],
                    margin: hasMaxWidth
                        ? const EdgeInsets.fromLTRB(56.0, 0.0, 56.0, 0.0)
                        : null,
                    constraints: const BoxConstraints(
                        maxWidth: maxWidth, minHeight: 48.0),
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (isAnimating || index == positions.length - 1) {
                          return;
                        }

                        final bool isScrollingDown = details.delta.dy > 0.0;

                        setState(() {
                          if (isScrollingDown && index > 0) {
                            index--;
                            isAnimating = true;
                          } else if (!isScrollingDown &&
                              index < positions.length - 1) {
                            index++;
                            isAnimating = true;
                          }
                        });
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (isAnimating || index != positions.length - 1) {
                            return false;
                          }

                          final ScrollDirection direction =
                              scrollController.position.userScrollDirection;

                          if (direction != ScrollDirection.forward) {
                            return false;
                          }
                          if (scrollController.offset > 0.0) return false;

                          setState(() {
                            index--;
                            isAnimating = true;
                          });

                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: isFullyExpanded
                              ? const BouncingScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 22.0, bottom: 22.0),
                                decoration: BoxDecoration(
                                  color: surface,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(28.0),
                                      topRight: Radius.circular(28.0)),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 32.0,
                                    height: 4.0,
                                    decoration: BoxDecoration(
                                        color: isFullyExpanded
                                            ? Colors.transparent
                                            : onSurfaceVariant,
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                  ),
                                ),
                              ),
                              widget.content,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
              }),
            ),
          ],
        ),
      ],
    );
  }
}
