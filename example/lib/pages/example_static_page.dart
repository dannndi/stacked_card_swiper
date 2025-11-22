import 'package:flutter/material.dart';
import 'package:stacked_card_swiper/stacked_card_swiper.dart';

class ExampleStaticPage extends StatefulWidget {
  const ExampleStaticPage({super.key});

  @override
  State<ExampleStaticPage> createState() => _ExampleStaticPageState();
}

class _ExampleStaticPageState extends State<ExampleStaticPage> {
  var direction = Axis.horizontal;
  final selectedColorNotifier = ValueNotifier(Colors.primaries.first);

  @override
  void dispose() {
    selectedColorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stacked Card Static"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ValueListenableBuilder(
              valueListenable: selectedColorNotifier,
              builder: (context, color, _) {
                return Container(
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [color, Colors.transparent],
                    ),
                  ),
                );
              },
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 450),
                    child: StackedCardSwiper(
                      values: Colors.primaries.take(4).toList(),
                      onChanged: (color) {
                        selectedColorNotifier.value = color;
                      },
                      swipeAxis: direction,
                      builder: (context, color) {
                        return Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text("Your Content"),
                        );
                      },
                    ),
                  ),

                  Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vertical Swipe"),
                      Switch(
                        value: direction == Axis.vertical,
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              direction = Axis.vertical;
                            } else {
                              direction = Axis.horizontal;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
