// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // --------------------- MODELS ---------------------

// class BlogEntry {
//   final String title;
//   final String subtitle;
//   final String details;

//   BlogEntry({
//     required this.title,
//     required this.subtitle,
//     required this.details,
//   });
// }

// // --------------------- PROVIDERS ---------------------

// class KnowledgeProvider with ChangeNotifier {
//   List<BlogEntry> _entries = [];

//   List<BlogEntry> get entries => _entries;

//   void addEntry(BlogEntry entry) {
//     _entries.add(entry);
//     notifyListeners();
//   }

//   void removeEntry(BlogEntry entry) {
//     _entries.remove(entry);
//     notifyListeners();
//   }
// }

// // --------------------- WIDGETS ---------------------

// // Blog List Page
// class BlogListPage extends StatefulWidget {
//   @override
//   _BlogListPageState createState() => _BlogListPageState();
// }

// class _BlogListPageState extends State<BlogListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final blogs = context.watch<KnowledgeProvider>().entries;

//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: _buildBody(blogs, context),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       title: Text(
//         'Blogs',
//         style: TextStyle(
//           fontFamily: 'Arial',
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.add_circle_outline),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CreateBlog()),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(List<BlogEntry> blogs, BuildContext context) {
//     if (blogs.isEmpty) {
//       return Center(
//         child: Text(
//           'No Blogs',
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.grey[600],
//           ),
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: blogs.length,
//         itemBuilder: (context, index) => _buildBlogItem(blogs[index], context),
//       );
//     }
//   }

//   Widget _buildBlogItem(BlogEntry blog, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Dismissible(
//         child: Card(
//           elevation: 4.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: ListTile(
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//             leading: Icon(Icons.book, color: Colors.blueAccent),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Topic: ${blog.title}',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(height: 5), // Add some spacing between the two lines
//                 Text('Subtitle: ${blog.subtitle}'),
//               ],
//             ),
//             trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
//             onTap: () {}, // Navigate to blog detail view if needed
//           ),
//         ),
//         key: ValueKey(blog),
//         direction: DismissDirection.endToStart,
//         background: Container(
//           color: Colors.red,
//           child: Icon(Icons.delete, color: Colors.white),
//           alignment: Alignment.centerRight,
//           padding: EdgeInsets.only(right: 20),
//         ),
//         onDismissed: (direction) {
//           context.read<KnowledgeProvider>().removeEntry(blog);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Blog deleted!')),
//           );
//         },
//       ),
//     );
//   }
// }

// // Create Blog Form
// class CreateBlog extends StatefulWidget {
//   @override
//   _CreateBlogPageState createState() => _CreateBlogPageState();
// }

// class _CreateBlogPageState extends State<CreateBlog> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedTopic;
//   String? _selectedSubtitle;
//   String? _details; // <-- Add this to store the details

//   final List<String> _topics = ['Model', 'Maintenance'];

//   final Map<String, List<String>> _detailsOptions = {
//     'Model': ['G22-75', 'GA22', 'GA75 VSD', 'GA55', 'GA75'],
//     'Maintenance': ['เปลี่ยนตามรอบ', 'เปลี่ยนตามอาการ'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Blog'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               DropdownButtonFormField<String>(
//                 items: _topics.map((String topic) {
//                   return DropdownMenuItem<String>(
//                     value: topic,
//                     child: Text(topic),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedTopic = value;
//                     _selectedSubtitle = null; // Reset the second dropdown
//                   });
//                 },
//                 value: _selectedTopic,
//                 hint: Text('Select Topic'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select a topic';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               if (_selectedTopic != null)
//                 DropdownButtonFormField<String>(
//                   items: _detailsOptions[_selectedTopic!]!.map((String detail) {
//                     return DropdownMenuItem<String>(
//                       value: detail,
//                       child: Text(detail),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedSubtitle = value;
//                     });
//                   },
//                   value: _selectedSubtitle,
//                   hint: Text('Select Detail'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a detail';
//                     }
//                     return null;
//                   },
//                 ),
//               SizedBox(height: 10),
//               TextFormField(
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   labelText: 'Details',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   _details = value;
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please provide details';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     if (_selectedTopic != null && _selectedSubtitle != null) {
//                       final newEntry = BlogEntry(
//                         title: _selectedTopic!,
//                         subtitle: _selectedSubtitle!,
//                         details: _details!,
//                       );
//                       context.read<KnowledgeProvider>().addEntry(newEntry);
//                       Navigator.pop(context);
//                     }
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
