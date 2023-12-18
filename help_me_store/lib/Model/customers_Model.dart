import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:uuid/uuid.dart';

class Customers {
  String Id;
  String company;
  String? address;
  String? contactPerson;
  String? contactNumber;
  String? position;

  Customers({
    required this.Id,
    required this.company,
    this.address,
    this.contactPerson,
    this.contactNumber,
    this.position,
  });

  // Convert a Customers instance to a Map. Useful for encoding to JSON or saving to a database.
  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'company': company,
      'address': address,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'position': position,
    };
  }

  // Create a Customers from a Map. Useful for decoding from JSON or a database.
  factory Customers.fromMap(Map<String, dynamic> map) {
    return Customers(
      Id: map['Id'],
      company: map['company'],
      address: map['address'],
      contactPerson: map['contactPerson'],
      contactNumber: map['contactNumber'],
      position: map['position'],
    );
  }
}

List<Customers> companies = [
  Customers(
    Id: Uuid().v4(),
    company: 'ABC manufacturing Co., Ltd.',
    contactPerson: 'สมชาย ใจดี',
    contactNumber: '089-123-4567',
    position: 'Engineer',
  ),
  Customers(
    Id: Uuid().v4(),
    company: 'Coal Mine Co., Ltd.',
    contactPerson: 'วรรณี มีมาตร',
    contactNumber: '087-987-6543',
    position: 'Machinary Manager',
  ),
  Customers(
    Id: Uuid().v4(),
    company: 'ConstructMat Co., Ltd.',
    contactPerson: 'พรพิมล สุขสวัสดิ์',
    contactNumber: '095-234-5678',
    position: 'Operation Manager',
  ),
  Customers(
    Id: Uuid().v4(),
    company: 'Boring Co., Ltd.',
    contactPerson: 'ณัฐวุฒิ รุ่งเรือง',
    contactNumber: '088-345-6789',
    position: 'Technician Manager',
  ),
  Customers(
    Id: Uuid().v4(),
    company: 'Plasmatic Co., Ltd.',
    contactPerson: 'สิริวรรณ ช่างเรือ',
    contactNumber: '092-567-8901',
    position: 'Production Engineer',
  ),
  Customers(
    Id: Uuid().v4(),
    company: 'Motor Part Co., Ltd.',
    contactPerson: 'วิชัย คงสุข',
    contactNumber: '093-456-7890',
    position: 'Maintainance Engineer',
  ),
];

class CustomersProvider extends ChangeNotifier {
  List<Customers> _customers = [
    ...companies
  ]; // Copy the original "companies" list

  List<Customers> get customers => _customers;
  var uuid = Uuid();

  void addCustomer(Customers customer) {
    print('Add customer @ provider is called');
    customer.Id = uuid.v4();
    _customers.add(customer);
    notifyListeners();
  }

  void updateCustomer(Customers updatedCustomer) {
    print('Update customer @ provider is called');
    // Find the customer by ID
    int index =
        _customers.indexWhere((customer) => customer.Id == updatedCustomer.Id);
    if (index != -1) {
      _customers[index] = updatedCustomer;
      notifyListeners();
    }
  }

  void removeCustomer(Customers removedcustomer) {
    print('Delete customer @ provider is called');

    _customers.removeWhere((customer) => customer.Id == removedcustomer.Id);
    notifyListeners();
  }
}
