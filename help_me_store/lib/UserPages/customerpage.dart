import 'package:flutter/material.dart';

import 'package:help_me_store/Pages/serviceReport_history.dart';

class CustomerPage extends StatelessWidget {
  final Map<String, IconData> itemIcons = {
    'Report History': Icons.menu_book_outlined,
  };

  final Map<String, Widget> itemRoutes = {
    'Report History': ServiceReportHistory(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Customers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle the notification button press
              // For example, navigate to a notification page or show a dialog
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: itemIcons.keys.map((item) {
            return InkWell(
              onTap: () {
                final widget = itemRoutes[item];
                if (widget != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => widget));
                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(itemIcons[item], size: 48.0, color: Colors.blueAccent),
                    SizedBox(height: 10),
                    Text(
                      item,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Blank', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
