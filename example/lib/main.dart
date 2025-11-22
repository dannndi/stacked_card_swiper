import 'package:example/pages/example_list_page.dart';
import 'package:example/pages/example_static_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: {
        "/": (context) => HomePage(),
        "/static": (context) => ExampleStaticPage(),
        "/list": (context) => ExampleListPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stacked Card Swiper Example")),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/static');
              },
              child: Text("Example Static"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
              child: Text("Example List"),
            ),
          ],
        ),
      ),
    );
  }
}
