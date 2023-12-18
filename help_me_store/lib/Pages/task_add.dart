import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Model/employees_Model.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:help_me_store/Pages/task.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

//2. Add Task Page
class AddTaskPage extends StatefulWidget {
  final String projectId;

  AddTaskPage({required this.projectId});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var uuid = Uuid(); // Add this line to create a Uuid instance

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedTaskType;
  Customers? _selectedCustomer;
  String? _selectedServiceTeamMember;

  DateTime _selectedDate = DateTime.now();

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      // Assuming you have a way to get the current logged-in user's ID
      String loggedInUserId = 'getCurrentLoggedInUserId()';

      final newTask = Task(
        Id: uuid.v4(),
        customer: _selectedCustomer,
        projectId: widget.projectId,
        taskType: _selectedTaskType,
        date: _selectedDate,
        note: _noteController.text,
        serviceteam: _selectedServiceTeamMember,
        status: TaskStatus.assigned,
        contactPerson: _contactPersonController.text,
        contactNumber: _contactNumberController.text,
        brand: _brandController.text,
        model: _modelController.text,
        serial: _serialNumberController.text,
        assignedEmployeeId: loggedInUserId, // Set to the logged-in user's ID
      );

      Provider.of<TaskProvider>(context, listen: false)
          .addOrUpdateTask(newTask);
      print('Created task: $newTask');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task created successfully!'),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCustomerDetails();
  }

  void _initializeCustomerDetails() {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    final project = projectProvider.getProjectById(widget.projectId);
    if (project != null) {
      _selectedCustomer = project.customer;
      _contactPersonController.text = project.contactPerson;
      _contactNumberController.text = project.contactNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Employee> employees = Provider.of<EmployeeProvider>(context).employees;
    List<Employee> specialists = employees
        .where((employee) => employee.position == "Specialist")
        .toList();
    List<String> specialistNames = specialists
        .map((specialist) =>
            "${specialist.firstName} ${specialist.lastName} (${specialist.nickName})")
        .toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Create Task',
            style: headingTextStyle,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  InputField(
                    title: "Task Type",
                    hint: _selectedTaskType,
                    dropdownItems: taskTypes,
                    onDropdownChanged: (newtasktype) {
                      setState(() {
                        _selectedTaskType = newtasktype;
                      });
                    },
                    isDropdown: true,
                    isvalidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Task type';
                      }
                      return null; // return null if the input is valid
                    },
                  ),
                  InputField<Customers>(
                    title: "Customer",
                    hint: _selectedCustomer?.company,
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
                    // Removed the validator as the customer is pre-filled and should not be null
                  ),
                  InputField(
                    title: "Contact Person",
                    hint: _selectedCustomer != null
                        ? _selectedCustomer!.contactPerson
                        : 'Enter contact person',
                    controller: _contactPersonController,
                    isDropdown: false,
                    isvalidator: (value) {
                      if (value == null) {
                        return 'Please select a contact person';
                      }
                      return null; // return null if the input is valid
                    },
                  ),
                  InputField(
                    title: "Contact Number",
                    hint: _selectedCustomer != null
                        ? _selectedCustomer!.contactNumber
                        : 'Enter contact number',
                    controller: _contactNumberController,
                    isDropdown: false,
                    isvalidator: (value) {
                      if (value == null) {
                        return 'Please enter a contact number';
                      }
                      return null;
                    },
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
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      icon: (Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.grey,
                      )),
                      onPressed: () {
                        _getDateFromUser();
                      },
                    ),
                    isDropdown: false,
                  ),
                  InputField(
                    title: "Assign to",
                    hint: _selectedServiceTeamMember ??
                        'Select Service Team Member',
                    dropdownItems: specialistNames,
                    onDropdownChanged: (newServiceTeamMember) {
                      setState(() {
                        _selectedServiceTeamMember = newServiceTeamMember;
                      });
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
                          final newTask = Task(
                            Id: uuid.v4(),
                            customer: _selectedCustomer,
                            contactPerson: _contactPersonController.text,
                            contactNumber: _contactNumberController.text,
                            taskType: _selectedTaskType,
                            projectId: widget.projectId,
                            brand: _brandController.text,
                            model: _modelController.text,
                            serial: _serialNumberController.text,
                            date: _selectedDate,
                            serviceteam: _selectedServiceTeamMember,
                            note: _noteController.text,
                            status: TaskStatus.assigned,
                            assignedEmployeeId: _selectedServiceTeamMember !=
                                    null
                                ? specialists
                                    .firstWhere((specialist) =>
                                        "${specialist.firstName} ${specialist.lastName} (${specialist.nickName})" ==
                                        _selectedServiceTeamMember)
                                    .Id
                                : null,
                          );

                          Provider.of<TaskProvider>(context, listen: false)
                              .addOrUpdateTask(newTask);

                          // Pop back to the CreateTask page
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Colors.lightGreen, // Text Color (Foreground color)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Create Task',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2120));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
