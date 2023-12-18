import 'package:flutter/material.dart';

class ProductRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product Request'),
      ),
      body: const Center(
        child: Text('Blank Page'),
      ),
    );
  }
}
