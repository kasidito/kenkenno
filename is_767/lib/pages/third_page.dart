import 'package:flutter/material.dart';

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
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/4');
            },
            icon: Icon(Icons.navigate_next),
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
