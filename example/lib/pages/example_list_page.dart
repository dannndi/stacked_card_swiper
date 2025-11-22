import 'package:flutter/material.dart';
import 'package:stacked_card_swiper/stacked_card_swiper.dart';

class ExampleListPage extends StatefulWidget {
  const ExampleListPage({super.key});

  @override
  State<ExampleListPage> createState() => _ExampleListPageState();
}

class _ExampleListPageState extends State<ExampleListPage> {
  var direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stacked Card Static"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 450),
            child: Column(
              spacing: 16,
              children: [
                ...List.generate(2, (index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade400),
                  );
                }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StackedCardSwiper(
                      values: Colors.primaries,
                      onChanged: (color) {},
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
                ...List.generate(10, (index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade400),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
