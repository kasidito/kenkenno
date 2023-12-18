import 'package:flutter/material.dart';

import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/employees_Model.dart';
import 'package:help_me_store/Model/goodIssues_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';

import 'package:help_me_store/UserPages/customersupportpage.dart';
import 'package:help_me_store/UserPages/customerpage.dart';
import 'package:help_me_store/UserPages/salespage.dart';
import 'package:help_me_store/UserPages/stockpage.dart';
import 'package:help_me_store/front.dart';
import 'package:provider/provider.dart';

import 'package:help_me_store/UserPages/servicepage.dart.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductListProvider()),
          ChangeNotifierProvider(create: (context) => CustomersProvider()),
          ChangeNotifierProvider(create: (context) => ProjectProvider()),
          ChangeNotifierProvider(create: (context) => TaskProvider()),
          ChangeNotifierProvider(create: (context) => ServiceReportProvider()),
          ChangeNotifierProvider(create: (context) => EmployeeProvider()),
          // ChangeNotifierProvider(create: (context) => TicketProvider()),
          // ChangeNotifierProvider(create: (context) => GoodIssueProvider()),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => FrontPage(),
        '/1': (context) => CustomerServicePage(),
        '/2': (context) => ServicePage(),
        '/3': (context) => StockPage(),
        '/4': (context) => SalesPage(),
        '/5': (context) => CustomerPage(),
      },
    );
  }
}
