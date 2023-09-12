import 'package:flutter/material.dart';

class Fifthpage extends StatefulWidget {
  @override
  State<Fifthpage> createState() => _FifthpageState();
}

class _FifthpageState extends State<Fifthpage> {
  String _gender = '';
  String _favcolor = '';
  String _pet = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 5'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              var choice = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    choices: ['Male', 'Female', 'Others', 'Prefer not to say'],
                  ),
                ),
              );
              setState(() {
                _gender = choice;
              });
            },
            child: Text('Select your gender - $_gender'),
          ),
          ElevatedButton(
            onPressed: () async {
              var choice = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    choices: ['Red', 'Yellow', 'Orange', 'Rainbow'],
                  ),
                ),
              );
              setState(() {
                _favcolor = choice;
              });
            },
            child: Text('Select your favorite color - $_favcolor'),
          ),
          ElevatedButton(
            onPressed: () async {
              var choice = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    choices: ['Dog', 'Cat', 'Rabbit', 'Hate Pet'],
                  ),
                ),
              );
              setState(() {
                _pet = choice;
              });
            },
            child: Text('Select your pet - $_pet'),
          ),
        ],
      ),
    );
  }
}

class PreferencePage extends StatelessWidget {
  final List<String> choices;

  const PreferencePage({super.key, required this.choices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your preference'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: choices.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                Navigator.pop(context, choices[index]);
              },
              child: Text('${choices[index]}'),
            );
          },
        ),
      ),
    );
  }
}
