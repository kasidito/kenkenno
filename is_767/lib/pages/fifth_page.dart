import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fifthpage extends StatefulWidget {
  @override
  State<Fifthpage> createState() => _FifthpageState();
}

class _FifthpageState extends State<Fifthpage> {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    type: 'gender',
                    choices: ['Male', 'Female', 'Others', 'Prefer not to say'],
                  ),
                ),
              );
            },
            child: Consumer<PreferenceModel>(
              builder: (context, value, child) {
                return Text('Select your gender - ${value.gender}');
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    type: 'favcolor',
                    choices: ['Red', 'Yellow', 'Orange', 'Rainbow'],
                  ),
                ),
              );
            },
            child: Consumer<PreferenceModel>(
              builder: (context, value, child) {
                return Text('Select your favorite color - ${value.favcolor}');
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencePage(
                    type: 'pet',
                    choices: ['Dog', 'Cat', 'Rabbit', 'Hate Pet'],
                  ),
                ),
              );
            },
            child: Consumer<PreferenceModel>(
              builder: (context, value, child) {
                return Text('Select your pet - ${value.pet}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PreferencePage extends StatelessWidget {
  final List<String> choices;
  final String type;

  const PreferencePage({super.key, required this.type, required this.choices});

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
                if (type == 'gender') {
                  context.read<PreferenceModel>().gender = choices[index];
                }
                if (type == 'favcolor') {
                  context.read<PreferenceModel>().favcolor = choices[index];
                }
                if (type == 'pet') {
                  context.read<PreferenceModel>().pet = choices[index];
                }

                Navigator.pop(context);
              },
              child: Text('${choices[index]}'),
            );
          },
        ),
      ),
    );
  }
}

class PreferenceModel extends ChangeNotifier {
  String _gender = '';
  String _favcolor = '';
  String _pet = '';

  get gender => this._gender;
  set gender(value) {
    this._gender = value;
    notifyListeners();
  }

  get favcolor => this._favcolor;
  set favcolor(value) {
    this._favcolor = value;
    notifyListeners();
  }

  get pet => this._pet;
  set pet(value) {
    this._pet = value;
    notifyListeners();
  }
}
