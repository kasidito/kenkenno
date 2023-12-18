import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:provider/provider.dart';
// Import your CustomersProvider

class UpdateCustomerPage extends StatefulWidget {
  final Customers customer;

  UpdateCustomerPage({required this.customer});

  @override
  _UpdateCustomerPageState createState() => _UpdateCustomerPageState();
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _companyController.text = widget.customer.company;
    _contactPersonController.text = widget.customer.contactPerson ?? '';
    _contactNumberController.text = widget.customer.contactNumber ?? '';
    _positionController.text = widget.customer.position ?? '';
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

  void _updateCustomer() {
    if (_formKey.currentState!.validate()) {
      // Create an updated customer object
      Customers updatedCustomer = Customers(
        Id: widget.customer.Id,
        company: _companyController.text,
        contactPerson: _contactPersonController.text,
        contactNumber: _contactNumberController.text,
        position: _positionController.text,
      );

      // Update the customer in the provider
      Provider.of<CustomersProvider>(context, listen: false)
          .updateCustomer(updatedCustomer);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Update Customer'),
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
                  onPressed: _updateCustomer,
                  child: Text('Update Customer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
