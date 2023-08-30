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
      initialRoute: '/first',
      routes: {
        '/first': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
        '/third': (context) => ThirdPage(),
      },
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('images/iu_image.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('images/iu_image.jpeg'),
              ),
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
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('First Page'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Hello ...'),
                ),
              );
            },
            icon: Icon(Icons.add_alert),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Center(
        child: Text('Blank page'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final List<String> entries = ['A', 'B', 'C', 'D', 'E', 'F'];
  final List<int> colorCodes = [600, 500, 300, 200, 100, 0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Second Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/third');
            },
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Container(
            height: 150.0,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: Text('Item ${entries[index]}'),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: entries.length,
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final List<String> images = [
    'images/view1.jpg',
    'images/view2.jpg',
    'images/view3.jpg',
    'images/view4.jpg',
    'images/view5.jpg',
    'images/view6.jpg',
    'images/view7.jpg',
    'images/view8.jpg',
    'images/view9.jpg',
    'images/view10.jpeg',
  ];
  final List<int> colorCodes = [
    900,
    700,
    500,
    300,
    100,
    300,
    500,
    700,
    900,
    700
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Third Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return Container(
            height: 150.0,
            color: Colors.blue[colorCodes[index]],
            child: Center(
              child: Image(image: AssetImage(images[index])),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: images.length,
      ),
    );
  }
}
