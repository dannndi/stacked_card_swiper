import 'package:flutter/material.dart';
import 'package:stacked_card_swiper/src/widget/card_widget.dart';

/// A widget that displays cards in a stacked layout
/// allowing users to swipe to switch between cards.
///
/// This widget is designed for **card switching / rotating interaction**
/// where the top card changes when swiped, while maintaining a layered,
/// stacked visual appearance.
class StackedCardSwiper<T> extends StatefulWidget {
  const StackedCardSwiper({
    super.key,
    required this.values,
    this.aspectRatio = 16 / 9,
    required this.builder,
    this.onChanged,
    this.swipeAxis = Axis.horizontal,
  });

  /// List of values rendered as stacked cards.
  final List<T> values;

  /// Aspect ratio applied to each card.
  final double aspectRatio;

  /// Function used to build the card UI.
  final Widget Function(BuildContext, T) builder;

  /// Called when the active (top) card changes.
  final void Function(T)? onChanged;

  /// Direction used for swipe interaction.
  final Axis swipeAxis;

  @override
  State<StackedCardSwiper<T>> createState() => _StackedCardState<T>();
}

class _StackedCardState<T> extends State<StackedCardSwiper<T>> {
  final valuesNotifier = ValueNotifier<List<T>>([]);

  @override
  void initState() {
    valuesNotifier.value = widget.values;
    super.initState();
  }

  @override
  void dispose() {
    valuesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valuesNotifier,
      builder: (context, values, child) {
        return Padding(
          padding: values.length > 2
              ? const EdgeInsets.only(top: 40)
              : values.length > 1
              ? const EdgeInsets.only(top: 20)
              : EdgeInsets.zero,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: List.generate(values.length, (index) {
              final value = values[index];
              return CardWidget(
                key: ObjectKey(value),
                index: index,
                value: value,
                swipeAxis: widget.swipeAxis,
                onAction: () {
                  final newList = List.of(values);
                  newList.remove(value);
                  newList.add(value);
                  valuesNotifier.value = newList;

                  widget.onChanged?.call(newList.first);
                },
                aspectRatio: widget.aspectRatio,
                builder: widget.builder,
              );
            }).reversed.toList(),
          ),
        );
      },
    );
  }
}
