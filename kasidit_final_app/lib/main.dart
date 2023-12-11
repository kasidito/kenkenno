import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kasidit_final_app/models/movies_Model.dart';
import 'package:kasidit_final_app/pages/moviesList.dart';
import 'package:kasidit_final_app/pages/schedule.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MoviesProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => MoviesListPage(),
        '/schedule': (context) => SchedulesListPage(),
      },
    );
  }
}
