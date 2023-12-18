import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Pages/project_Sales.dart';

import 'package:help_me_store/Pages/task_add.dart';

import 'package:provider/provider.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddProjectPage extends StatefulWidget {
  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _projectnameController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _projectdetailsController =
      TextEditingController();

  String? _selectedProjectType;
  Customers? _selectedCustomer;
  DateTime _selectedstartDate = DateTime.now();
  DateTime _selectedendDate = DateTime.now();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Create Project', style: headingTextStyle),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  title: "Project Name",
                  hint: "Enter Project Name",
                  controller: _projectnameController,
                  isDropdown: false,
                ),

                // Project Type Dropdown
                InputField(
                  title: "Project Type",
                  hint: _selectedProjectType ?? 'Select Project Type',
                  dropdownItems: projectTypes,
                  onDropdownChanged: (String? newType) {
                    setState(() {
                      _selectedProjectType = newType;
                    });
                  },
                  isDropdown: true,
                ),

                // Customer Dropdown
                Consumer<CustomersProvider>(
                  builder: (context, provider, child) {
                    return InputField<Customers>(
                      title: "Customer",
                      hint: _selectedCustomer?.company ?? 'Select Customer',
                      dropdownItems: provider.customers,
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
                    );
                  },
                ),

                // Auto-filled Contact Person
                InputField(
                  title: "Contact Person",
                  hint: 'Enter contact person',
                  controller: _contactPersonController,
                  isDropdown: false,
                ),

                // Auto-filled Contact Number
                InputField(
                  title: "Contact Number",
                  hint: 'Enter contact number',
                  controller: _contactNumberController,
                  isDropdown: false,
                ),

                // Date Picker
                InputField(
                  title: "Start Date",
                  hint: DateFormat.yMd().format(_selectedstartDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                    onPressed: _pickStartDateFromUser,
                  ),
                  isDropdown: false,
                ),

                // Date Picker for End Date
                InputField(
                  title: "End Date",
                  hint: DateFormat.yMd().format(_selectedendDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                    onPressed: _pickEndDateFromUser,
                  ),
                  isDropdown: false,
                ),

                // Note Field
                InputField(
                  title: "Project Detail",
                  hint: "Enter detail here.",
                  controller: _projectdetailsController,
                  isDropdown: false,
                ),
                // Submit Button
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text('Create Project',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCustomer == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a customer')),
        );
        return;
      }

      final newProject = Project(
        Id: uuid.v4(),
        projectName: _projectnameController.text,
        projectType: _selectedProjectType,
        customer: _selectedCustomer!,
        contactPerson: _contactPersonController.text,
        contactNumber: _contactNumberController.text,
        startDate: _selectedstartDate,
        endDate: _selectedendDate,
        timeStamp: DateTime.now(),
        projectDetails: _projectdetailsController.text,
        status: ProjectStatus.planning,
      );

      try {
        Provider.of<ProjectProvider>(context, listen: false)
            .addProject(newProject);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Success adding project: ${newProject.projectName}')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding project: $e')),
        );
      }
    }
  }

  void _pickStartDateFromUser() async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _selectedstartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedStartDate != null && pickedStartDate != _selectedstartDate) {
      setState(() {
        _selectedstartDate = pickedStartDate;
      });
    }
  }

  void _pickEndDateFromUser() async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _selectedendDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedEndDate != null && pickedEndDate != _selectedendDate) {
      setState(() {
        _selectedendDate = pickedEndDate;
      });
    }
  }
}
