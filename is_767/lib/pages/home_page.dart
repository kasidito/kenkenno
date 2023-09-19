import 'package:flutter/material.dart';
import 'package:is_767/pages/fifth_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Consumer<PreferenceModel>(
          builder: (context, value, child) {
            return Text('Home - ${value.gender}');
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(5, (index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/${index + 1}');
            },
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Text('Go to page ${index + 1}'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
