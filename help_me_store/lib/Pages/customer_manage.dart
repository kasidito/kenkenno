import 'package:flutter/material.dart';
import 'package:help_me_store/Model/customers_Model.dart';
import 'package:help_me_store/Pages/Customer_edit.dart';
import 'package:help_me_store/Pages/customer_add.dart';
import 'package:help_me_store/Widgets/font.dart';
import 'package:provider/provider.dart';

class CustomerManagePage extends StatefulWidget {
  @override
  _CustomerManagePageState createState() => _CustomerManagePageState();
}

class _CustomerManagePageState extends State<CustomerManagePage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Customer List',
          style: headingTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddCustomerPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search customers',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              searchController.clear();
                              searchQuery = "";
                            });
                          },
                          child: Icon(Icons.clear, color: Colors.grey),
                        ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<CustomersProvider>(
              builder: (context, provider, child) {
                List<Customers> filteredCustomers = provider.customers
                    .where((customer) =>
                        customer.company.toLowerCase().contains(searchQuery) ||
                        (customer.contactPerson
                                ?.toLowerCase()
                                .contains(searchQuery) ??
                            false))
                    .toList();

                return ListView.builder(
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = filteredCustomers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          title: Text(customer.company, style: titleTextStle),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${customer.contactPerson ?? 'N/A'}',
                                    style: subTitleTextStle),
                                SizedBox(height: 2),
                                Text('Tel: ${customer.contactNumber ?? 'N/A'}',
                                    style: subTitleTextStle),
                                SizedBox(height: 2),
                                Text('Position: ${customer.position ?? 'N/A'}',
                                    style: subTitleTextStle),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateCustomerPage(customer: customer),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
