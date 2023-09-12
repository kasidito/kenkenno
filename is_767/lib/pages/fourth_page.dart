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
          selection: TextSelection.collapsed(offset: newValue.text.length + 1));
    }
    return newValue;
  }
}

class _FourthPageState extends State<FourthPage> {
  final _formKey = GlobalKey<FormState>();

  String _cardname = "";
  String _cardNumber = "";
  String _cvvnumber = "";
  String _validdate = "";

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
                  onSaved: (newValue) {
                    _cardname = newValue!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLength: 16,
                  decoration: _inputDecoration('CARD NUMBER'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Card Number';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Incorrect Format';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _cardNumber = newValue!;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
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
                        onSaved: (newValue) {
                          _cvvnumber = newValue!;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
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
                        onSaved: (newValue) {
                          _validdate = newValue!;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmPayment(
                                detail: PaymentDetail(
                                  _cardname,
                                  _cardNumber,
                                  _cvvnumber,
                                  _validdate,
                                ),
                              ),
                            ),
                          );
                        }
                        ;
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

class ConfirmPayment extends StatelessWidget {
  final PaymentDetail detail;

  const ConfirmPayment({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(detail.name),
              Text(detail.cardNumber),
              Text(detail.CVV),
              Text(detail.ValidDate),
            ],
          ),
        ));
  }
}

class PaymentDetail {
  final String name;
  final String cardNumber;
  final String CVV;
  final String ValidDate;

  const PaymentDetail(this.name, this.cardNumber, this.CVV, this.ValidDate);
}
