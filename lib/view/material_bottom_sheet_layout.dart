import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yeohaeng_ttukttak_v3/view/material_sheet_view.dart';

class MaterialBottomSheetLayout extends StatefulWidget implements MaterialSheetLayout {
  
  @override
  final MaterialSheetHeader header;
  @override
  final MaterialSheetListContent content;
  @override
  final MaterialSheetBackgroundBuilder backgroundBuilder;

  const MaterialBottomSheetLayout({
    super.key,
    required this.header,
    required this.content,
    required this.backgroundBuilder,
  });

  @override
  State<MaterialBottomSheetLayout> createState() => _MaterialBottomSheetLayoutState();
}

class _MaterialBottomSheetLayoutState extends State<MaterialBottomSheetLayout> {
  final ScrollController scrollController = ScrollController();

  final List<double> positions = [0.0, 0.5, 1.0];

  static const double maxWidth = 640.0;
  static const double scrollThreshold = -32.0;

  double sheetHeight = 0.0;

  int index = 1;

  bool isAnimating = false;
  bool isContentScrolled = false;

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
        widget.backgroundBuilder(sheetHeight),
        AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: isFullyExpanded ? surface : Colors.transparent),
        Column(
          children: [
            AnimatedCrossFade(
                firstChild: widget.header.headerBuilder(isFullyExpanded),
                secondChild: widget.header.appBar,
                crossFadeState: isContentScrolled
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250)),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final BoxConstraints(maxWidth: width, maxHeight: height) =
                    constraints;
                final EdgeInsets(:top) = MediaQuery.of(context).padding;
                final bool hasMaxWidth = width > maxWidth;

                sheetHeight = (height - top) * positions[index];
                return Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    AnimatedContainer(
                      onEnd: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        setState(() => isAnimating = false);
                      },
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      width: double.maxFinite,
                      height: sheetHeight,
                      margin: hasMaxWidth
                          ? const EdgeInsets.fromLTRB(56.0, 0.0, 56.0, 0.0)
                          : null,
                      constraints: BoxConstraints(
                          maxWidth: maxWidth,
                          minHeight: 48.0,
                          maxHeight: height),
                      decoration: BoxDecoration(
                          color: surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28.0),
                            topRight: Radius.circular(28.0),
                          ),
                          boxShadow: !isFullyExpanded
                              ? [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 8.0,
                                      spreadRadius: 0.0,
                                      color:
                                          Colors.black.withValues(alpha: 0.15)),
                                  BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 3.0,
                                      spreadRadius: 0.0,
                                      color:
                                          Colors.black.withValues(alpha: 0.15)),
                                ]
                              : null),
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
                        child: NotificationListener<ScrollUpdateNotification>(
                          onNotification:
                              (ScrollUpdateNotification notification) {
                            // 본문 스크롤 여부를 업데이트
                            bool isContentScrolled =
                                scrollController.offset > 0.0;

                            if (this.isContentScrolled != isContentScrolled) {
                              setState(() =>
                                  this.isContentScrolled = isContentScrolled);
                            }

                            // 위로 끝까지 스크롤 시 시트 축소
                            if (isAnimating || index != positions.length - 1) {
                              return false;
                            }

                            final ScrollDirection direction =
                                scrollController.position.userScrollDirection;

                            if (direction != ScrollDirection.forward) {
                              return false;
                            }
                            if (scrollController.offset > scrollThreshold)
                              return false;

                            setState(() {
                              index--;
                              isAnimating = true;
                            });

                            return false;
                          },
                          child: CustomScrollView(
                            controller: scrollController,
                            physics: isFullyExpanded
                                ? const BouncingScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                  child: AnimatedCrossFade(
                                      firstChild: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              top: 22.0, bottom: 22.0),
                                          child: Center(
                                              child: Container(
                                            width: 32.0,
                                            height: 4.0,
                                            decoration: BoxDecoration(
                                                color: isFullyExpanded
                                                    ? Colors.transparent
                                                    : onSurfaceVariant,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ))),
                                      secondChild: const SizedBox(height: 8.0),
                                      crossFadeState: isFullyExpanded
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      duration: 
                                          const Duration(milliseconds: 250))),
                              SliverToBoxAdapter(child: widget.content.title),
                              SliverList.builder(
                                  itemCount: widget.content.itemCount,
                                  itemBuilder: widget.content.itemBuilder)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
