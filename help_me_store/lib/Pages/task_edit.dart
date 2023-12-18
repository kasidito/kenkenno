import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/employees_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Pages/task.dart';
import 'package:help_me_store/Pages/task_add.dart';

import 'package:help_me_store/Widgets/input_field.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// 3. Edit Page
class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task, required bool isViewOnly});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _selectedTaskType;
  late DateTime _selectedDate;
  late String _selectedServiceTeam;
  late Customers? _selectedCustomer;

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<String> _serviceTeamOptions = []; // List to hold dropdown options

  @override
  void initState() {
    super.initState();
    _selectedTaskType = widget.task.taskType ?? '';
    _selectedDate = widget.task.date ?? DateTime.now();
    _selectedServiceTeam = widget.task.serviceteam ?? '';
    _selectedCustomer = widget.task.customer;
    _brandController.text = widget.task.brand ?? '';
    _modelController.text = widget.task.model ?? '';
    _serialNumberController.text = widget.task.serial ?? '';
    _contactPersonController.text = widget.task.contactPerson ?? '';
    _contactNumberController.text = widget.task.contactNumber ?? '';
    _noteController.text = widget.task.note ?? '';
    _populateServiceTeams();
  }

  void _populateServiceTeams() {
    List<Employee> employees =
        Provider.of<EmployeeProvider>(context, listen: false).employees;
    _serviceTeamOptions = employees
        .where((e) => e.position == "Specialist")
        .map((e) => "${e.firstName} ${e.lastName} (${e.nickName})")
        .toList();

    // Set the selected service team if it matches one of the options
    if (_serviceTeamOptions.contains(_selectedServiceTeam)) {
      setState(() {
        _selectedServiceTeam = _selectedServiceTeam;
      });
    } else {
      // Reset the selected service team if it doesn't match
      setState(() {
        _selectedServiceTeam = _serviceTeamOptions[0];
      });
    }
  }

  void _pickDateFromUser() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Edit Task',
          style: headingTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  title: "Task Type",
                  hint: _selectedTaskType ?? "Select Task Type",
                  controller: TextEditingController(text: _selectedTaskType),
                  dropdownItems: taskTypes,
                  onDropdownChanged: (String? newTaskType) {
                    if (newTaskType != null) {
                      setState(() {
                        _selectedTaskType = newTaskType;
                      });
                    }
                  },
                  isDropdown: true,
                ),
                InputField<Customers>(
                  title: "Customer",
                  hint: _selectedCustomer?.company ?? 'Select Customer',
                  dropdownItems: companies,
                  itemToString: (Customers customer) => customer.company,
                  onDropdownChanged: (Customers? newCustomer) {
                    setState(() {
                      _selectedCustomer = newCustomer;
                      _contactPersonController.text =
                          newCustomer?.contactPerson ?? '';
                      _contactNumberController.text =
                          newCustomer?.contactNumber ?? '';
                    });
                  },
                  isDropdown: true,
                ),
                InputField(
                  title: "Contact Person",
                  hint: _selectedCustomer != null
                      ? _selectedCustomer!.contactPerson
                      : 'Enter contact person',
                  controller: _contactPersonController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Contact Number",
                  hint: _selectedCustomer != null
                      ? _selectedCustomer!.contactNumber
                      : 'Enter contact number',
                  controller: _contactNumberController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Brand",
                  hint: "Enter Brand here.",
                  controller: _brandController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Model",
                  hint: "Enter Model here.",
                  controller: _modelController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Serial Number",
                  hint: "Enter Serial Number here.",
                  controller: _serialNumberController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Date",
                  hint: DateFormat.yMd()
                      .format(_selectedDate), // Format the date as needed
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _pickDateFromUser(); // Call a method to pick the date
                    },
                  ),
                  isDropdown: false,
                ),
                InputField(
                  title: "Service Team",
                  hint: _selectedServiceTeam ?? "Select Service Team",
                  dropdownItems: _serviceTeamOptions,
                  onDropdownChanged: (String? newServiceTeam) {
                    if (newServiceTeam != null) {
                      setState(() {
                        _selectedServiceTeam = newServiceTeam;
                      });
                    }
                  },
                  isDropdown: true,
                ),
                InputField(
                  title: "Note",
                  hint: "Enter note here.",
                  controller: _noteController,
                  isDropdown: false,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update the task

                        widget.task.brand = _brandController.text;
                        widget.task.model = _modelController.text;
                        widget.task.serial = _serialNumberController.text;
                        widget.task.taskType = _selectedTaskType;
                        widget.task.date = _selectedDate;
                        widget.task.note = _noteController.text;
                        widget.task.customer = _selectedCustomer;
                        widget.task.serviceteam = _selectedServiceTeam;

                        // Update the task in the provider
                        Provider.of<TaskProvider>(context, listen: false)
                            .addOrUpdateTask(widget.task);

                        // Pop back to the Create page
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16),
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
