import 'package:flutter/material.dart';
import 'package:midterm_app/pages/createblog.dart';
import 'package:provider/provider.dart';

//1. How to
class HowTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('How to...'),
      ),
      body: Consumer<KnowledgeProvider>(
        builder: (context, provider, child) {
          final entries = provider.entries;
          if (entries.isEmpty) {
            return Center(child: Text('No Blog'));
          } else {
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      leading: Icon(Icons.book,
                          color: Colors.blueAccent), // Example icon
                      title: Text('Topic: ${entry.title}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Subtitle: ${entry.subtitle}'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogDetailPage(entry: entry),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

//2. Blog Detail Page
class BlogDetailPage extends StatelessWidget {
  final BlogEntry entry;

  BlogDetailPage({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Topic',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                entry.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.blueGrey[200]),
              SizedBox(height: 20),
              Text(
                'Subtitle',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                entry.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.blueGrey[200]),
              SizedBox(height: 20),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                entry.details,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              // Add more details or widgets here if needed
            ],
          ),
        ),
      ),
    );
  }
}
