import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Employee {
  String Id;
  String firstName;
  String lastName;
  String nickName;
  String position;
  String contactNumber;
  String? note;

  Employee({
    required this.Id,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.position,
    required this.contactNumber,
    this.note,
  });

  // Convert a Employee instance to a Map. Useful for encoding to JSON or saving to a database.
  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'position': position,
      'contactNumber': contactNumber,
      'note': note,
    };
  }

  // Create an Employee from a Map. Useful for decoding from JSON or a database.
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      Id: map['Id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      nickName: map['nickName'],
      position: map['position'],
      contactNumber: map['contactNumber'],
      note: map['note'],
    );
  }
}

class EmployeeProvider with ChangeNotifier {
  List<Employee> _employees = [...mockEmployees()];

  List<Employee> get employees => _employees;

  void addEmployee(Employee employee) {
    employee.Id = Uuid().v4();
    _employees.add(employee);
    notifyListeners();
  }

  // Method to update an existing employee
  void updateEmployee(Employee updatedEmployee) {
    final index = _employees.indexWhere((e) => e.Id == updatedEmployee.Id);
    if (index != -1) {
      _employees[index] = updatedEmployee;
      notifyListeners();
    }
  }

  // Method to remove an employee
  void removeEmployee(String employeeId) {
    _employees.removeWhere((e) => e.Id == employeeId);
    notifyListeners();
  }
}

List<Employee> mockEmployees() {
  var uuid = Uuid();
  return [
    Employee(
      Id: uuid.v4(),
      firstName: '',
      lastName: '',
      nickName: '',
      position: '',
      contactNumber: '',
      note: '',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'สมชาย',
      lastName: 'ใจดี',
      nickName: 'Art',
      position: 'Specialist',
      contactNumber: '089-123-4567',
      note: 'Specialized in Air Dryer',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'กิตติ',
      lastName: 'สุขใจ',
      nickName: 'Max',
      position: 'Specialist',
      contactNumber: '098-765-4321',
      note: 'Specialized in Air Compressor and Air Dryer',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'วิชัย',
      lastName: 'คงสุข',
      nickName: 'Boy',
      position: 'Specialist',
      contactNumber: '092-345-6789',
      note: 'Specialized in Air Compressor maintenance',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'ณัฐวุฒิ',
      lastName: 'รุ่งเรือง',
      nickName: 'Ton',
      position: 'Specialist',
      contactNumber: '093-456-7890',
      note: 'Specialized in Air Compressor designing systems',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'สุรชัย',
      lastName: 'เจริญผล',
      nickName: 'Golf',
      position: 'Specialist',
      contactNumber: '094-567-8901',
      note: 'Specialized in Air Compressor and Air Dryer servicing',
    ),
    Employee(
      Id: uuid.v4(),
      firstName: 'ประเสริฐ',
      lastName: 'มั่งคั่ง',
      nickName: 'Non',
      position: 'Specialist',
      contactNumber: '095-678-9012',
      note: 'Specialized in Air Compressor',
    ),
  ];
}
