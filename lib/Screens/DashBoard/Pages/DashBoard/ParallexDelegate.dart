import 'package:flutter/material.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState? scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable?.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.expand(
        width: constraints.maxWidth,
        height: scrollable?.position.viewportDimension);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable?.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemSize = context.size;

    //Gets the offset of the top of the list item from the top of the viewport
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.topCenter(Offset.zero),
        ancestor: scrollableBox);

    // Get the size of the background image
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;

    //Gets the vertical size of the viewport (excludes appbars)
    final viewportDimension = scrollable?.position.viewportDimension ?? 1.0;

    // Determine the percent position of this list item within the
    // scrollable area.
    // - scrollFraction is 1 if listItem's top edge is at the bottom of the
    //   viewport.
    // - scrollFraction is 0 if listItem's top edge is at the top of the
    //   viewport
    // - scrollFraction is -1 if listItem's bottom edge is at the top of the
    //   viewport
    final double scrollFraction, yOffset;
    if (listItemOffset.dy > 0) {
      scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0, 1.0);
      yOffset = -scrollFraction * backgroundSize.height;
    } else {
      scrollFraction = (listItemOffset.dy / listItemSize.height).clamp(-1, 0);
      yOffset = -scrollFraction * listItemSize.height;
    }

    // Paint the background.
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0, yOffset)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
