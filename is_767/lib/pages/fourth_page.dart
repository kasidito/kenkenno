import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourthPage extends StatefulWidget {
  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _ValidThroughInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 2 && oldValue.text.length == 1) {
      return TextEditingValue(
        text: '${newValue.text}/',
      );
    }
    return newValue;
  }
}

class _FourthPageState extends State<FourthPage> {
  final _formKey = GlobalKey<FormState>();

  InputDecoration _inputDecoration(String lable) {
    return InputDecoration(
      labelText: lable,
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Fourth Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PAYMENT DETAILS',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _inputDecoration('NAME ON CARD'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Name on The Card';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLength: 16,
                  decoration: _inputDecoration('CARD NUMBER'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Card Number';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Incorrect Format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLength: 3,
                        decoration: _inputDecoration('CVV'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the CVV';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Incorrect Format';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        maxLength: 5,
                        decoration: _inputDecoration('VALID THROUGH'),
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9/]")),
                          _ValidThroughInputFormat()
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Valid Through';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing Payment...'),
                            ),
                          );
                        }
                      },
                      child: Text('PAYMENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
