import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:intl/intl.dart';

import 'package:help_me_store/Widgets/input_field.dart';

class ServiceReportDetailPage extends StatelessWidget {
  final ServiceReport serviceReport;

  ServiceReportDetailPage({required this.serviceReport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Report Detail'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDetailCard('Header Details', [
              _buildDetailRow(
                  'Project Name', serviceReport.projectName ?? 'N/A'),
              _buildDetailRow('Task Type', serviceReport.taskType ?? 'N/A'),
              _buildDetailRow('Service Date',
                  DateFormat.yMd().format(serviceReport.serviceDate)),
              _buildDetailRow('Service Time',
                  serviceReport.serviceTime?.format(context) ?? 'N/A'),
              _buildDetailRow('Brand', serviceReport.brand ?? 'N/A'),
              _buildDetailRow('Model', serviceReport.model ?? 'N/A'),
              _buildDetailRow('Serial Number', serviceReport.serial ?? 'N/A'),
            ]),
            SizedBox(height: 20),
            _buildDetailCard('Technical Details', [
              _buildDetailRow('Ambient Temperature',
                  '${serviceReport.ambientTemp ?? 'N/A'} °C'),
              _buildDetailRow('Sump Pressure Load',
                  '${serviceReport.sumpPressLoad ?? 'N/A'} bar'),
              _buildDetailRow('Sump Pressure Unload',
                  '${serviceReport.sumpPressUnLoad ?? 'N/A'} bar'),
              _buildDetailRow('Discharge Pressure Load',
                  '${serviceReport.dischPressLoad ?? 'N/A'} bar'),
              _buildDetailRow('Discharge Pressure Unload',
                  '${serviceReport.dischPressUnLoad ?? 'N/A'} bar'),
              _buildDetailRow('Air End Discharge Temperature',
                  '${serviceReport.airEndDischTemp ?? 'N/A'} °C'),
              _buildDetailRow('Air Discharge Temperature',
                  '${serviceReport.airDischTemp ?? 'N/A'} °C'),
              _buildDetailRow('1st Discharge Pressure Two Stage',
                  '${serviceReport.firstDischPressTwoStage ?? 'N/A'} °C'),
              _buildDetailRow('Pressure Drop',
                  '${serviceReport.pressureDrop ?? 'N/A'} bar'),
              _buildDetailRow(
                  'Air Filter Part Number', serviceReport.airFilterPN ?? 'N/A'),
              _buildDetailRow('Air Filter Hours',
                  '${serviceReport.airFilterHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Air Filter Change Required', serviceReport.airFilterCR),
              _buildDetailRow(
                  'Oil Filter Part Number', serviceReport.oilFilterPN ?? 'N/A'),
              _buildDetailRow('Oil Filter Hours',
                  '${serviceReport.oilFilterHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Oil Filter Change Required', serviceReport.oilFilterCR),
              _buildDetailRow(
                  'Separator Part Number', serviceReport.separatorPN ?? 'N/A'),
              _buildDetailRow('Separator Hours',
                  '${serviceReport.separatorHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Separator Change Required', serviceReport.separatorCR),
              _buildDetailRow(
                  'Lubricant Part Number', serviceReport.lubricantPN ?? 'N/A'),
              _buildDetailRow('Lubricant Hours',
                  '${serviceReport.lubricantHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Lubricant Change Required', serviceReport.lubricantCR),
              _buildDetailRow('Inlet Valve Part Number',
                  serviceReport.inletValvePN ?? 'N/A'),
              _buildDetailRow('Inlet Valve Hours',
                  '${serviceReport.inletValveHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Inlet Valve Change Required', serviceReport.inletValveCR),
              _buildDetailRow('Blow Down Hours',
                  '${serviceReport.blowDownHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Blow Down Change Required', serviceReport.blowDownCR),
              _buildDetailRow('Minimum Check Valve Hours',
                  '${serviceReport.minCheckValveHr ?? 'N/A'} hours'),
              _buildDetailRow('Minimum Check Valve Change Required',
                  serviceReport.minCheckValveCR),
              _buildDetailRow('Hoses', serviceReport.hoses ?? 'N/A'),
              _buildDetailRow(
                  'Hoses Hours', '${serviceReport.hosesHr ?? 'N/A'} hours'),
              _buildDetailRow('Hoses Change Required', serviceReport.hosesCR),
              _buildDetailRow('Water Temperature',
                  '${serviceReport.waterTemp ?? 'N/A'} °C'),
              _buildDetailRow('Coupling Hours',
                  '${serviceReport.couplingHr ?? 'N/A'} hours'),
              _buildDetailRow(
                  'Coupling Change Required', serviceReport.couplingCR),
              _buildDetailRow(
                  'Voltage Load', '${serviceReport.voltageLoad ?? 'N/A'} V'),
              _buildDetailRow('Voltage Unload',
                  '${serviceReport.voltageUnload ?? 'N/A'} V'),
              _buildDetailRow(
                  'Current Load', '${serviceReport.currentLoad ?? 'N/A'} A'),
              _buildDetailRow('Current Unload',
                  '${serviceReport.currentUnload ?? 'N/A'} A'),
              _buildDetailRow(
                  'Thermostatic Valve', serviceReport.thermostaticValve),
              _buildDetailRow('Solenoid Valve', serviceReport.solenoidValve),
              _buildDetailRow('Auto Drain', serviceReport.autoDrain),
              _buildDetailRow('Temperature Sensor', serviceReport.tempSensor),
              _buildDetailRow('Pressure Sensor', serviceReport.pressureSensor),
              _buildDetailRow('Main Motor', serviceReport.mainMotor),
              _buildDetailRow('Fan Motor', serviceReport.fanMotor),
              _buildDetailRow(
                  'Magnetic Contactor', serviceReport.magneticContactor),
              _buildDetailRow('Scavenging', serviceReport.scavenging),
              _buildDetailRow('Board Control', serviceReport.boardControl),
              _buildDetailRow('Emergency Stop', serviceReport.emergencyStop),
              _buildDetailRow('Sound Level', serviceReport.sound),
            ]),
            SizedBox(height: 20),
            _buildDetailCard('Observations', [
              _buildDetailRow('Problem', serviceReport.problem ?? 'N/A'),
              _buildDetailRow(
                  'Recommendation', serviceReport.recommend ?? 'N/A'),
            ]),
            _buildDetailCard('Attached File', [
              _buildDetailRow('File Name',
                  serviceReport.attachedFileName ?? 'No file attached'),
            ]),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    // Store the file name in the serviceReport object
                    serviceReport.attachedFileName = file.name;
                    // You might want to notify listeners or update the state
                  } else {
                    // User canceled the picker
                  }
                },
                child: Text('Import Image/File'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, Object? value) {
    String displayValue;

    if (value is bool?) {
      displayValue = (value ?? false) ? 'Checked' : 'Replaced';
    } else {
      displayValue = value?.toString() ??
          "Not Applicable"; // Change "N/A" to "Not Applicable"
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(displayValue),
          ),
        ],
      ),
    );
  }
}
