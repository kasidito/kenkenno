import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Pages/project_add.dart';
import 'package:help_me_store/Pages/task_add.dart';

import 'package:provider/provider.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:intl/intl.dart';

class EditProjectPage extends StatefulWidget {
  final Project project;

  EditProjectPage({required this.project});

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _projectNameController;
  late TextEditingController _contactPersonController;
  late TextEditingController _contactNumberController;
  late TextEditingController _projectDetailsController;
  String? _selectedProjectType;
  Customers? _selectedCustomer;
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _projectNameController =
        TextEditingController(text: widget.project.projectName);
    _contactPersonController =
        TextEditingController(text: widget.project.contactPerson);
    _contactNumberController =
        TextEditingController(text: widget.project.contactNumber);
    _projectDetailsController =
        TextEditingController(text: widget.project.projectDetails);
    _selectedProjectType = widget.project.projectType;
    _selectedCustomer = widget.project.customer;
    _selectedStartDate = widget.project.startDate ?? DateTime.now();
    _selectedEndDate = widget.project.endDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _contactPersonController.dispose();
    _contactNumberController.dispose();
    _projectDetailsController.dispose();
    super.dispose();
  }

  void _pickStartDateFromUser() async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedStartDate != null) {
      setState(() => _selectedStartDate = pickedStartDate);
    }
  }

  void _pickEndDateFromUser() async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedEndDate != null) {
      setState(() => _selectedEndDate = pickedEndDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Edit Project'),
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
                  title: "Project Name",
                  hint: "Enter Project Name",
                  controller: _projectNameController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Project Type",
                  hint: _selectedProjectType ?? 'Select Project Type',
                  dropdownItems: projectTypes,
                  onDropdownChanged: (String? newType) {
                    setState(() {
                      _selectedProjectType = newType!;
                    });
                  },
                  isDropdown: true,
                ),
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
                InputField(
                  title: "Contact Person",
                  hint: 'Enter contact person',
                  controller: _contactPersonController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Contact Number",
                  hint: 'Enter contact number',
                  controller: _contactNumberController,
                  isDropdown: false,
                ),
                InputField(
                  title: "Start Date",
                  hint: DateFormat.yMd().format(_selectedStartDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                    onPressed: () {
                      _pickStartDateFromUser();
                    },
                  ),
                  isDropdown: false,
                ),
                InputField(
                  title: "End Date",
                  hint: DateFormat.yMd().format(_selectedEndDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                    onPressed: () {
                      _pickEndDateFromUser();
                    },
                  ),
                  isDropdown: false,
                ),
                InputField(
                  title: "Project Detail",
                  hint: "Enter detail here.",
                  controller: _projectDetailsController,
                  isDropdown: false,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _saveChanges(),
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

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      try {
        // Update the project object with new values
        widget.project.projectName = _projectNameController.text;
        widget.project.contactPerson = _contactPersonController.text;
        widget.project.contactNumber = _contactNumberController.text;
        widget.project.projectType = _selectedProjectType;

        // Check if _selectedCustomer is not null before assigning
        if (_selectedCustomer != null) {
          widget.project.customer = _selectedCustomer!;
        }

        widget.project.startDate = _selectedStartDate;
        widget.project.endDate = _selectedEndDate;
        widget.project.projectDetails = _projectDetailsController.text;

        Provider.of<ProjectProvider>(context, listen: false)
            .updateProject(widget.project);

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Changes saved successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving changes: $e')),
        );
      }
    }
  }
}
