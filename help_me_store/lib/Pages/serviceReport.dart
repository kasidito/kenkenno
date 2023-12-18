import 'package:flutter/material.dart';
import 'package:help_me_store/Model/projects_Model.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Pages/serviceReport_detail.dart';
import 'package:help_me_store/Pages/serviceReport_history.dart';

import 'package:help_me_store/Widgets/font.dart';
import 'package:help_me_store/Widgets/input_field.dart';
import 'package:help_me_store/Model/tasks_Model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ServiceReportPage extends StatefulWidget {
  final Task task;

  ServiceReportPage({required this.task});

  @override
  State<ServiceReportPage> createState() => _ServiceReportPageState();
}

class _ServiceReportPageState extends State<ServiceReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ServiceReport _serviceReport; // Declare _serviceReport as late
  var uuid = Uuid();
  // Declare the TextEditingControllers
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _serialNumberController;
  late TextEditingController _airFilterPNController;
  late TextEditingController _airFilterHrController;
  late TextEditingController _oilFilterPNController;
  late TextEditingController _oilFilterHrController;
  late TextEditingController _separatorPNController;
  late TextEditingController _separatorHrController;
  late TextEditingController _lubricantPNController;
  late TextEditingController _lubricantHrController;
  late TextEditingController _inletValvePNController;
  late TextEditingController _inletValveHrController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  // Declare the ValueNotifiers
  ValueNotifier<bool>? airFilterCRNotifier;
  ValueNotifier<bool>? oilFilterCRNotifier;
  ValueNotifier<bool>? separatorCRNotifier;
  ValueNotifier<bool>? lubricantCRNotifier;
  ValueNotifier<bool>? inletValveCRNotifier;
  ValueNotifier<bool>? blowDownCRNotifier;
  ValueNotifier<bool>? minCheckValveCRNotifier;
  ValueNotifier<bool>? hosesCRNotifier;
  ValueNotifier<bool>? couplingCRNotifier;
  ValueNotifier<bool>? thermostaticValveNotifier;
  ValueNotifier<bool>? solenoidValveNotifier;
  ValueNotifier<bool>? autoDrainNotifier;
  ValueNotifier<bool>? tempSensorNotifier;
  ValueNotifier<bool>? pressureSensorNotifier;
  ValueNotifier<bool>? mainMotorNotifier;

  ValueNotifier<bool>? fanMotorNotifier;
  ValueNotifier<bool>? magneticContactorNotifier;
  ValueNotifier<bool>? scavengingNotifier;
  ValueNotifier<bool>? boardControlNotifier;
  ValueNotifier<bool>? emergencyStopNotifier;
  ValueNotifier<bool>? soundNotifier;

  @override
  void initState() {
    super.initState();

    // Access the ProjectProvider
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    // Fetch the project using projectId
    Project? project =
        projectProvider.getProjectById(widget.task.projectId ?? '');

    // Initialize _serviceReport first
    _serviceReport = ServiceReport(
      Id: uuid.v4(),
      taskId: widget.task.Id,
      projectName: project?.projectName, // Set the project name
      taskType: widget.task.taskType,
      brand: widget.task.brand,
      model: widget.task.model,
      serial: widget.task.serial,
      serviceDate: DateTime.now(),
      timeStamp: DateTime.now(),
      serviceName: widget.task.serviceteam,
      status: ServiceReportStatus.Task,
    );
    // Initialize the notifier with the initial value
    airFilterCRNotifier = ValueNotifier(_serviceReport.airFilterCR ?? true);
    oilFilterCRNotifier = ValueNotifier(_serviceReport.oilFilterCR ?? true);
    separatorCRNotifier = ValueNotifier(_serviceReport.separatorCR ?? true);
    lubricantCRNotifier = ValueNotifier(_serviceReport.lubricantCR ?? true);
    inletValveCRNotifier = ValueNotifier(_serviceReport.inletValveCR ?? true);
    blowDownCRNotifier = ValueNotifier(_serviceReport.blowDownCR ?? true);
    minCheckValveCRNotifier =
        ValueNotifier(_serviceReport.minCheckValveCR ?? true);
    hosesCRNotifier = ValueNotifier(_serviceReport.hosesCR ?? true);
    couplingCRNotifier = ValueNotifier(_serviceReport.couplingCR ?? true);
    thermostaticValveNotifier =
        ValueNotifier(_serviceReport.thermostaticValve ?? true);
    solenoidValveNotifier = ValueNotifier(_serviceReport.solenoidValve ?? true);
    autoDrainNotifier = ValueNotifier(_serviceReport.autoDrain ?? true);
    tempSensorNotifier = ValueNotifier(_serviceReport.tempSensor ?? true);
    pressureSensorNotifier =
        ValueNotifier(_serviceReport.pressureSensor ?? true);
    mainMotorNotifier = ValueNotifier(_serviceReport.mainMotor ?? true);
    fanMotorNotifier = ValueNotifier(_serviceReport.fanMotor ?? true);
    magneticContactorNotifier =
        ValueNotifier(_serviceReport.magneticContactor ?? true);
    scavengingNotifier = ValueNotifier(_serviceReport.scavenging ?? true);
    boardControlNotifier = ValueNotifier(_serviceReport.boardControl ?? true);
    emergencyStopNotifier = ValueNotifier(_serviceReport.emergencyStop ?? true);
    soundNotifier = ValueNotifier(_serviceReport.sound ?? true);

    // Initialize TextEditingControllers
    _brandController = TextEditingController(text: _serviceReport.brand);
    _modelController = TextEditingController(text: _serviceReport.model);
    _serialNumberController =
        TextEditingController(text: _serviceReport.serial);
    _airFilterPNController =
        TextEditingController(text: _serviceReport.airFilterPN);
    _airFilterHrController =
        TextEditingController(text: _serviceReport.airFilterHr?.toString());
    _oilFilterPNController =
        TextEditingController(text: _serviceReport.oilFilterPN);
    _oilFilterHrController =
        TextEditingController(text: _serviceReport.oilFilterHr?.toString());
    _separatorPNController =
        TextEditingController(text: _serviceReport.separatorPN);
    _separatorHrController =
        TextEditingController(text: _serviceReport.separatorHr?.toString());
    _lubricantPNController =
        TextEditingController(text: _serviceReport.lubricantPN);
    _lubricantHrController =
        TextEditingController(text: _serviceReport.lubricantHr?.toString());
    _inletValvePNController =
        TextEditingController(text: _serviceReport.inletValvePN?.toString());
    _inletValveHrController =
        TextEditingController(text: _serviceReport.inletValveHr?.toString());
    _dateController = TextEditingController(
      text: DateFormat.yMd().format(_serviceReport.serviceDate),
    );
    TimeOfDay defaultTime = TimeOfDay.now();
    _dateController = TextEditingController(
      text: DateFormat.yMd().format(_serviceReport.serviceDate),
    );
    _timeController = TextEditingController(
      text: DateFormat.jm().format(
        DateTime(
          0,
          0,
          0,
          _serviceReport.serviceTime?.hour ?? defaultTime.hour,
          _serviceReport.serviceTime?.minute ?? defaultTime.minute,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
    _airFilterPNController.dispose();
    _airFilterHrController.dispose();
    _oilFilterPNController.dispose();
    _oilFilterHrController.dispose();
    _separatorPNController.dispose();
    _separatorHrController.dispose();
    _lubricantPNController.dispose();
    _lubricantHrController.dispose();
    _inletValvePNController.dispose();
    _inletValveHrController.dispose();
    _dateController.dispose();
    _timeController.dispose();

    // airFilterCRNotifier.dispose();
    // oilFilterCRNotifier.dispose();
    // separatorCRNotifier.dispose();
    // lubricantCRNotifier.dispose();
    // inletValveCRNotifier.dispose();
    // blowDownCRNotifier.dispose();
    // minCheckValveCRNotifier.dispose();
    // hosesCRNotifier.dispose();
    // couplingCRNotifier.dispose();
    // thermostaticValveNotifier.dispose();
    // solenoidValveNotifier.dispose();
    // autoDrainNotifier.dispose();
    // tempSensorNotifier.dispose();
    // pressureSensorNotifier.dispose();
    // mainMotorNotifier.dispose();
    // fanMotorNotifier.dispose();
    // magneticContactorNotifier.dispose();
    // scavengingNotifier.dispose();
    // boardControlNotifier.dispose();
    // emergencyStopNotifier.dispose();
    // soundNotifier.dispose();

    // ... dispose other controllers ...
    super.dispose();
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _serviceReport.serviceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      setState(() {
        _serviceReport.serviceDate = pickedDate;

        // Update the controller instead of _serviceReport
        _dateController?.text = DateFormat.yMd().format(pickedDate);
      });
    }
  }

  _getTimeFromUser() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _serviceReport.serviceTime = pickedTime;
        // Update the controller instead of _serviceReport
        _timeController?.text = DateFormat.jm()
            .format(DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute));
      });
    }
  }

  Widget _buildSwitchInputField({
    required String title,
    required String normal,
    required String faulty,
    required ValueNotifier<bool> valueNotifier,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                value ? normal : faulty,
                style: TextStyle(
                  color: value ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: value,
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                onChanged: (newValue) {
                  valueNotifier.value = newValue;
                  // Update the _serviceReport object as well
                  _serviceReport.airFilterCR = newValue;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Create Service Report',
          style: headingTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                title: "Project Name",
                hint: "Enter Project Name",
                controller:
                    TextEditingController(text: _serviceReport.projectName),
                isDropdown: false,
              ),
              InputField(
                title: "Task Type",
                hint: _serviceReport.taskType,
                dropdownItems: taskTypes,
                onDropdownChanged: (newTaskType) {
                  setState(() {
                    _serviceReport.taskType = newTaskType;
                  });
                },
                isDropdown: true,
                isvalidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Task type';
                  } else {
                    return null;
                  }
                },
              ),
              InputField(
                title: "Service Date",
                controller: _dateController, // Use the controller
                widget: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _getDateFromUser,
                ),
              ),
              InputField(
                title: "Service Time",
                controller: _timeController, // Use the controller
                widget: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _getTimeFromUser,
                ),
              ),

              InputField(
                title: "Brand",
                hint: 'Enter Brand',
                controller: TextEditingController(text: _serviceReport.brand),
                isvalidator: (value) {
                  if (value == null || value == '') {
                    return 'Please enter a brand';
                  }
                  return null;
                },
              ),

              InputField(
                title: "Model",
                hint: 'Enter Model',
                controller: TextEditingController(text: _serviceReport.model),
                isvalidator: (value) {
                  if (value == null || value == '') {
                    return 'Please enter a brand';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Serial Number",
                hint: 'Enter Serial Number',
                controller:
                    TextEditingController(text: _serviceReport.serial ?? ''),
                isvalidator: (value) {
                  if (value == null) {
                    return 'Please enter a brand';
                  }
                  return null;
                },
              ),
              //Service Report Details
              InputField(
                title: "Ambient Temperature (°C)",
                hint: 'Max 45°C',
                controller: TextEditingController(
                    text: _serviceReport.ambientTemp?.toString() ?? ''),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ambient temperature';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Sump Pressure Load (P1)",
                hint: '5-13 bar',
                controller: TextEditingController(
                    text: _serviceReport.sumpPressLoad?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Sump Pressure at Load';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Sump Pressure at Unload (P1)",
                hint: '1-3.5 bar',
                controller: TextEditingController(
                    text: _serviceReport.sumpPressUnLoad?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Sump Pressure at Unload';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Discharge at Load (P2)",
                hint: '5-13 bar',
                controller: TextEditingController(
                    text: _serviceReport.dischPressLoad?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Discharge at Load';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Discharge at Unload (P2)",
                hint: '5-13 bar',
                controller: TextEditingController(
                    text: _serviceReport.dischPressUnLoad?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Discharge at Unload';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Air End Discharge Temperature (°C)",
                hint: 'Max 113°C',
                controller: TextEditingController(
                    text: _serviceReport.airEndDischTemp?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Air End Discharge Temperature';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Air Discharge Temperature (°C)",
                hint: 'Max 113°C',
                controller: TextEditingController(
                    text: _serviceReport.airDischTemp?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Air Discharge Temperature';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "First Discharge Pressure Two Stage (°C)",
                hint: 'Max 100°C',
                controller: TextEditingController(
                    text: _serviceReport.firstDischPressTwoStage?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter First Discharge Pressure Two Stage';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Pressure Drop (∆P)",
                hint: '0.8-1.4 bar',
                controller: TextEditingController(
                    text: _serviceReport.pressureDrop?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Pressure Drop';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Air Filter Part Number",
                hint: 'Enter Air Filter Part Number',
                controller:
                    TextEditingController(text: _serviceReport.airFilterPN),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Air Filter Part Number';
                  }
                  return null;
                },
              ),

              InputField(
                title: "Air Filter Hours",
                hint: 'Enter Air Filter operating hours',
                controller: TextEditingController(
                    text: _serviceReport.airFilterHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Air Filter Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Air Filter Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: airFilterCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Oil Filter Part Number",
                hint: 'Enter Oil Filter Part Number',
                controller:
                    TextEditingController(text: _serviceReport.oilFilterPN),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Oil Filter Part Number';
                  }
                  return null;
                },
              ),

              InputField(
                title: "Oil Filter Hours",
                hint: 'Enter Oil Filter operating hours',
                controller: TextEditingController(
                    text: _serviceReport.oilFilterHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Oil Filter Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Oil Filter Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: oilFilterCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Separator Part Number",
                hint: 'Enter Separator Part Number',
                controller:
                    TextEditingController(text: _serviceReport.separatorPN),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Separator Part Number';
                  }
                  return null;
                },
              ),

              InputField(
                title: "Separator Hours",
                hint: 'Enter Separator operating hours',
                controller: TextEditingController(
                    text: _serviceReport.separatorHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Separator Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Separator Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: separatorCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Lubricant Part Number",
                hint: 'Enter Lubricant Part Number',
                controller:
                    TextEditingController(text: _serviceReport.lubricantPN),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Lubricant Part Number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Lubricant Hours",
                hint: 'Enter Lubricant operating hours',
                controller: TextEditingController(
                    text: _serviceReport.lubricantHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Lubricant Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Lubricant Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: lubricantCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Inlet Valve Part Number",
                hint: 'Enter Inlet Valve Part Number',
                controller: TextEditingController(
                    text: _serviceReport.inletValvePN?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Inlet Valve Part Number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Inlet Valve Hours",
                hint: 'Enter Inlet Valve operating hours',
                controller: TextEditingController(
                    text: _serviceReport.inletValveHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Inlet Valve Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Inlet Valve Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: inletValveCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Blow Down Hours",
                hint: 'Enter Blow Down operating hours',
                controller: TextEditingController(
                    text: _serviceReport.blowDownHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Blow Down Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Blow Down Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: blowDownCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Minimum Check Valve Hours",
                hint: 'Enter Minimum Check Valve operating hours',
                controller: TextEditingController(
                    text: _serviceReport.minCheckValveHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Minimum Check Valve Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Minimum Check Valve Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: minCheckValveCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Hoses",
                hint: 'Enter Hoses location',
                controller: TextEditingController(text: _serviceReport.hoses),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Hoses';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Hoses Hours",
                hint: 'Enter Hoses operating hours',
                controller: TextEditingController(
                    text: _serviceReport.hosesHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Hoses Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Hoses Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: hosesCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Water Temperature (°C)",
                hint: 'Enter Water Temperature',
                controller: TextEditingController(
                    text: _serviceReport.waterTemp?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Water Temperature';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                title: "Coupling Hours",
                hint: 'Enter Coupling operating hours',
                controller: TextEditingController(
                    text: _serviceReport.couplingHr?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Coupling Hours';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              _buildSwitchInputField(
                title: "Coupling Change Required",
                normal: 'Check',
                faulty: 'Replace',
                valueNotifier: couplingCRNotifier ?? ValueNotifier(true),
              ),
              InputField(
                title: "Voltage Load (V)",
                hint: 'Enter Voltage Load',
                controller: TextEditingController(
                    text: _serviceReport.voltageLoad?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Voltage Load';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),

              InputField(
                title: "Voltage Unload (V)",
                hint: 'Enter Voltage Unload',
                controller: TextEditingController(
                    text: _serviceReport.voltageUnload?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Voltage Unload';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              InputField(
                  title: "Current Load (A)",
                  hint: 'Enter Current Load',
                  controller: TextEditingController(
                      text: _serviceReport.currentLoad?.toString()),
                  isvalidator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Current Load';
                    }
                    if (num.tryParse(value) == null) {
                      return 'Please enter a only number';
                    }
                    return null;
                  }),
              InputField(
                title: "Current Unload (A)",
                hint: 'Enter Current Unload',
                controller: TextEditingController(
                    text: _serviceReport.currentUnload?.toString()),
                isvalidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Current Unload';
                  }
                  if (num.tryParse(value) == null) {
                    return 'Please enter a only number';
                  }
                  return null;
                },
              ),
              // ... Continue for all numeric fields ...

              //Boolean Fields---Boolean Fields---Boolean Fields---Boolean Fields---Boolean Fields---Boolean Fields
              Column(
                children: [
                  _buildSwitchInputField(
                    title: "Thermostatic Valve",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier:
                        thermostaticValveNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Solenoid Valve",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: solenoidValveNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Auto Drain",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: autoDrainNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Temperature Sensor",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: tempSensorNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Pressure Sensor",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier:
                        pressureSensorNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Main Motor",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: mainMotorNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Fan Motor",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: fanMotorNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Magnetic Contactor",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier:
                        magneticContactorNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Scavenging",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: scavengingNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Board Control",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: boardControlNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Emergency Stop",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: emergencyStopNotifier ?? ValueNotifier(true),
                  ),
                  _buildSwitchInputField(
                    title: "Sound",
                    normal: 'Normal',
                    faulty: 'Faulty',
                    valueNotifier: soundNotifier ?? ValueNotifier(true),
                  ),
                ],
              ),

              // ... Continue for all boolean fields ...
              InputField(
                title: "Problem",
                controller:
                    TextEditingController(text: _serviceReport.problem ?? ''),
              ),
              InputField(
                title: "Recommendation",
                controller:
                    TextEditingController(text: _serviceReport.recommend ?? ''),
              ),

              // ... Add other InputFields as needed ...
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create a new ServiceReport object and populate it with values
                      final newServiceReport = ServiceReport(
                        Id: uuid.v4(),
                        taskId: widget.task.Id,
                        projectName: _serviceReport.projectName,
                        taskType: _serviceReport.taskType,
                        serviceDate: _serviceReport.serviceDate,
                        serviceTime: _serviceReport.serviceTime,
                        timeStamp: _serviceReport.timeStamp,
                        brand: _serviceReport.brand,
                        model: _serviceReport.model,
                        serial: _serviceReport.serial,
                        ambientTemp: _serviceReport.ambientTemp,
                        sumpPressLoad: _serviceReport.sumpPressLoad,
                        sumpPressUnLoad: _serviceReport.sumpPressUnLoad,
                        dischPressLoad: _serviceReport.dischPressLoad,
                        dischPressUnLoad: _serviceReport.dischPressUnLoad,
                        airEndDischTemp: _serviceReport.airEndDischTemp,
                        airDischTemp: _serviceReport.airDischTemp,
                        firstDischPressTwoStage:
                            _serviceReport.firstDischPressTwoStage,
                        pressureDrop: _serviceReport.pressureDrop,
                        airFilterPN: _serviceReport.airFilterPN,
                        airFilterHr: _serviceReport.airFilterHr,
                        airFilterCR: _serviceReport.airFilterCR,
                        oilFilterPN: _serviceReport.oilFilterPN,
                        oilFilterHr: _serviceReport.oilFilterHr,
                        oilFilterCR: _serviceReport.oilFilterCR,
                        separatorPN: _serviceReport.separatorPN,
                        separatorHr: _serviceReport.separatorHr,
                        separatorCR: _serviceReport.separatorCR,
                        lubricantPN: _serviceReport.lubricantPN,
                        lubricantHr: _serviceReport.lubricantHr,
                        lubricantCR: _serviceReport.lubricantCR,
                        inletValvePN: _serviceReport.inletValvePN,
                        inletValveHr: _serviceReport.inletValveHr,
                        inletValveCR: _serviceReport.inletValveCR,
                        blowDownHr: _serviceReport.blowDownHr,
                        blowDownCR: _serviceReport.blowDownCR,
                        minCheckValveHr: _serviceReport.minCheckValveHr,
                        minCheckValveCR: _serviceReport.minCheckValveCR,
                        hoses: _serviceReport.hoses,
                        hosesHr: _serviceReport.hosesHr,
                        hosesCR: _serviceReport.hosesCR,
                        waterTemp: _serviceReport.waterTemp,
                        couplingHr: _serviceReport.couplingHr,
                        couplingCR: _serviceReport.couplingCR,
                        voltageLoad: _serviceReport.voltageLoad,
                        voltageUnload: _serviceReport.voltageUnload,
                        currentLoad: _serviceReport.currentLoad,
                        currentUnload: _serviceReport.currentUnload,
                        thermostaticValve: _serviceReport.thermostaticValve,
                        solenoidValve: _serviceReport.solenoidValve,
                        autoDrain: _serviceReport.autoDrain,
                        tempSensor: _serviceReport.tempSensor,
                        pressureSensor: _serviceReport.pressureSensor,
                        mainMotor: _serviceReport.mainMotor,
                        fanMotor: _serviceReport.fanMotor,
                        magneticContactor: _serviceReport.magneticContactor,
                        scavenging: _serviceReport.scavenging,
                        boardControl: _serviceReport.boardControl,
                        emergencyStop: _serviceReport.emergencyStop,
                        sound: _serviceReport.sound,
                        problem: _serviceReport.problem,
                        recommend: _serviceReport.recommend,
                        status: _serviceReport.status,
                      );

                      Provider.of<ServiceReportProvider>(context, listen: false)
                          .addReport(newServiceReport);
                      print('Report Created ${newServiceReport.Id}');
                      print(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ServiceReportHistory(),
                        ),
                      );
                    }
                  },
                  child: Text('Create Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
