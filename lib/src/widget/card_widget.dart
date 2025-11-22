import 'dart:math';

import 'package:flutter/widgets.dart';

class CardWidget<T> extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.index,
    required this.value,
    required this.onAction,
    required this.builder,
    required this.aspectRatio,
    this.swipeAxis = Axis.horizontal,
  });

  final int index;
  final T value;
  final VoidCallback onAction;
  final Widget Function(BuildContext, T) builder;
  final Axis swipeAxis;
  final double aspectRatio;

  @override
  State<CardWidget<T>> createState() => _CardWidgetState<T>();
}

class _CardWidgetState<T> extends State<CardWidget<T>> {
  Offset position = Offset.zero;
  bool isDragging = false;

  void onPanUpdate(Offset delta) {
    setState(() {
      isDragging = true;

      if (widget.swipeAxis == Axis.horizontal) {
        position += Offset(delta.dx, 0);
      }

      if (widget.swipeAxis == Axis.vertical) {
        position += Offset(0, delta.dy);
      }
    });
  }

  void onPanEnd() {
    final widgetHeight = context.size?.height ?? 1;
    final widgetWidth = context.size?.width ?? 1;

    if (widget.swipeAxis == Axis.horizontal) {
      if (position.dx.abs() >= widgetWidth * 0.4) {
        widget.onAction();
      }
    }

    if (widget.swipeAxis == Axis.vertical) {
      if (position.dy.abs() >= widgetHeight * 0.4) {
        widget.onAction();
      }
    }
    setState(() {
      isDragging = false;
      position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final width = constrains.maxWidth;
        final height = MediaQuery.sizeOf(context).height;

        return GestureDetector(
          onVerticalDragUpdate: widget.swipeAxis == Axis.vertical
              ? (details) => onPanUpdate(details.delta)
              : null,
          onVerticalDragEnd: widget.swipeAxis == Axis.vertical
              ? (details) => onPanEnd()
              : null,
          onHorizontalDragUpdate: widget.swipeAxis == Axis.horizontal
              ? (details) => onPanUpdate(details.delta)
              : null,
          onHorizontalDragEnd: widget.swipeAxis == Axis.horizontal
              ? (details) => onPanEnd()
              : null,
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: AnimatedContainer(
              duration: isDragging
                  ? const Duration(milliseconds: 100)
                  : const Duration(milliseconds: 400),
              alignment: Alignment.center,
              transform: Matrix4.identity()
                // scale the card
                ..translate(width / 2, 0)
                ..scale(max(1 - widget.index * 0.05, 0.8))
                ..translate(-width / 2, 0)
                // translate to top,
                ..translate(0.0, max(-20.0 * widget.index, -40))
                // rotate when swipe
                ..rotateZ(
                  widget.swipeAxis == Axis.horizontal
                      ? (position.dx / width) * 0.3
                      : (position.dy / height) * -0.7,
                )
                // swipe position
                ..translate(
                  position.dx,
                  widget.swipeAxis == Axis.horizontal
                      ? position.dx.abs() * -0.5
                      : position.dy,
                ),
              child: widget.builder(context, widget.value),
            ),
          ),
        );
      },
    );
  }
}
