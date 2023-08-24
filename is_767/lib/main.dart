import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hello Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _var1 = 10;
  int _var2 = 10;
  int _var3 = 10;

  void _invar1() {
    setState(() {
      _var1++;
    });
  }

  void _devar1() {
    setState(() {
      _var1--;
    });
  }

  void _invar2() {
    setState(() {
      _var2++;
    });
  }

  void _devar2() {
    setState(() {
      _var2--;
    });
  }

  void _mulvar3() {
    setState(() {
      _var3 *= 2;
    });
  }

  void _devvar3() {
    setState(() {
      _var3 ~/= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$_var1',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: _invar1,
                  child: Text('+++'),
                ),
                ElevatedButton(
                  onPressed: _devar1,
                  child: Text('---'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$_var2',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: _devar2,
                  child: Text('---'),
                ),
                ElevatedButton(
                  onPressed: _invar2,
                  child: Text('+++'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$_var3',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: _mulvar3,
                  child: Text('***'),
                ),
                ElevatedButton(
                  onPressed: _devvar3,
                  child: Text('///'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
