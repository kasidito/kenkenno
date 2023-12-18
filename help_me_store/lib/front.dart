import 'package:flutter/material.dart';

class MenuButton {
  final IconData icon;
  final String title;
  final String route;

  MenuButton({required this.icon, required this.title, required this.route});
}

class FrontPage extends StatelessWidget {
  final List<MenuButton> buttons = [
    MenuButton(icon: Icons.description, title: 'Customer Support', route: '/1'),
    MenuButton(icon: Icons.local_library, title: 'Service', route: '/2'),
    // MenuButton(icon: Icons.gavel, title: 'Stock', route: '/3'),
    MenuButton(icon: Icons.rocket_launch, title: 'Sales', route: '/4'),
    // MenuButton(icon: Icons.anchor, title: 'Customers', route: '/5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Text(
            'Select User',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(buttons.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, buttons[index].route);
            },
            child: Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.all(.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(buttons[index].icon, size: 45.0),
                    SizedBox(height: 10.0),
                    Text(
                      buttons[index].title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
