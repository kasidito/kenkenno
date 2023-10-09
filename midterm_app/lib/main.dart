import 'package:flutter/material.dart';
import 'package:midterm_app/pages/home.dart';
import 'package:midterm_app/pages/createblog.dart';
import 'package:midterm_app/pages/howto.dart';
import 'package:midterm_app/pages/page3.dart';
import 'package:midterm_app/pages/page4.dart';
import 'package:midterm_app/pages/page5.dart';
import 'package:midterm_app/pages/page6.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => KnowledgeProvider()),
          // Other providers
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 163, 3)),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/1': (context) => BlogListPage(),
        '/2': (context) => HowTo(),
        '/3': (context) => Page3(),
        '/4': (context) => Page4(),
        '/5': (context) => Page5(),
        '/6': (context) => Page6(),
      },
    );
  }
}
