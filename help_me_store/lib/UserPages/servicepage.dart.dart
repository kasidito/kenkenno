import 'package:flutter/material.dart';
import 'package:help_me_store/Model/serviceReport_Model.dart';
import 'package:help_me_store/Pages/jobBoard.dart';

import 'package:help_me_store/Pages/project_Service.dart';
import 'package:help_me_store/Pages/task.dart';
import 'package:help_me_store/Pages/goodIssue_order.dart';
import 'package:help_me_store/Pages/serviceReport.dart';
import 'package:help_me_store/Pages/serviceReport_history.dart';
import 'package:help_me_store/Pages/myWorks.dart';

class ServicePage extends StatelessWidget {
  final Map<String, IconData> managerSections = {
    'Projects': Icons.home_work,
    // 'Create Ticket': Icons.work,
    // 'Order Product': Icons.warehouse,
    // 'Service Report': Icons.list_alt,
    'Report History': Icons.menu_book_outlined,
  };

  final Map<String, IconData> specialistSections = {
    'My Works': Icons.work_history_sharp,
    // 'Service Report': Icons.list_alt,
    'Report History': Icons.menu_book_outlined,
    'Good Issues': Icons.warehouse,
    'Job Board': Icons.work,
  };

  final Map<String, Widget> itemRoutes = {
    'Projects': ProjectServicePage(),
    // 'Create Ticket': CreateTicket(),
    'My Works': MyWorksPage(),
    'Good Issues': GoodIssuesPage(),
    // 'Service Report': ServiceReportPage(),
    'Report History': ServiceReportHistory(),
    'Job Board': JobBoardPage(),
  };

  Widget buildSection(
      String title, Map<String, IconData> icons, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: icons.keys.map((item) {
            return InkWell(
              onTap: () {
                final widget = itemRoutes[item];
                if (widget != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => widget));
                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[item], size: 48.0, color: Colors.blueAccent),
                    SizedBox(height: 10),
                    Text(item,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Service',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle the notification button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSection("Manager", managerSections, context),
            buildSection("Specialists", specialistSections, context),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Theme.of(context).primaryColor,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('Blank', style: TextStyle(color: Colors.white)),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
