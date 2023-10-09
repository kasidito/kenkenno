import 'package:flutter/material.dart';

class MenuButton {
  final IconData icon;
  final String title;
  final String route;

  MenuButton({required this.icon, required this.title, required this.route});
}

class HomePage extends StatelessWidget {
  final List<MenuButton> buttons = [
    MenuButton(icon: Icons.description, title: 'Create Blog', route: '/1'),
    MenuButton(icon: Icons.local_library, title: 'How to', route: '/2'),
    MenuButton(icon: Icons.gavel, title: 'BP1', route: '/3'),
    MenuButton(icon: Icons.rocket_launch, title: 'BP2', route: '/4'),
    MenuButton(icon: Icons.anchor, title: 'BP3', route: '/5'),
    MenuButton(icon: Icons.android, title: 'BP4', route: '/6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Page'),
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
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(buttons[index].icon, size: 45.0),
                  SizedBox(height: 10.0),
                  Text(
                    buttons[index].title,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
