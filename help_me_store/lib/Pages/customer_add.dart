import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Pages/customer_manage.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactNumberController.addListener(_formatPhoneNumber);
  }

  @override
  void dispose() {
    _contactNumberController.removeListener(_formatPhoneNumber);
    _contactNumberController.dispose();
    super.dispose();
  }

  void _formatPhoneNumber() {
    String formatted = _contactNumberController.text.replaceAll('-', '');
    if (formatted.length > 3 && formatted.length <= 6) {
      formatted = formatted.substring(0, 3) + '-' + formatted.substring(3);
    } else if (formatted.length > 6) {
      formatted = formatted.substring(0, 3) +
          '-' +
          formatted.substring(3, 6) +
          '-' +
          formatted.substring(6);
    }
    _contactNumberController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _addCustomer() {
    if (_formKey.currentState!.validate()) {
      // Create a new customer
      var newCustomer = Customers(
        Id: Uuid().v4(),
        company: _companyController.text,
        contactPerson: _contactPersonController.text,
        contactNumber: _contactNumberController.text,
        position: _positionController.text,
      );

      // Use the provider to add the new customer
      Provider.of<CustomersProvider>(context, listen: false)
          .addCustomer(newCustomer);

      // Navigate back to the previous screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Add Customer',
          style: headingTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InputField<String>(
                title: 'Company',
                controller: _companyController,
                isvalidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              InputField<String>(
                title: 'Addreess',
                controller: _addressController,
                isvalidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company address';
                  }
                  return null;
                },
              ),
              InputField<String>(
                title: 'Contact Person',
                controller: _contactPersonController,
              ),
              InputField<String>(
                title: 'Contact Number',
                controller: _contactNumberController,
              ),
              InputField<String>(
                title: 'Position',
                controller: _positionController,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _addCustomer,
                  child: Text('Add Customer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
