import 'package:flutter/material.dart';
import 'package:is_767/pages/first_page.dart';
import 'package:is_767/pages/fourth_page.dart';
import 'package:is_767/pages/second_page.dart';
import 'package:is_767/pages/third_page.dart';
import 'package:is_767/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
        '/4': (context) => FourthPage(),
      },
    );
  }
}
