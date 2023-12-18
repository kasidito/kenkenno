// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Product {
//   final String assetName;
//   final String name;
//   final String detail;
//   final int stock;

//   Product({
//     required this.assetName,
//     required this.name,
//     required this.detail,
//     required this.stock,
//   });
// }

// class ProductListProvider with ChangeNotifier {
//   final List<Product> products = [
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/blower1.jpg',
//       name: 'Blower',
//       detail: 'This is the detail of product',
//       stock: 10,
//     ),
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/G132.jpg',
//       name: 'G132',
//       detail: 'This is the detail of product',
//       stock: 3,
//     ),
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/ga75+.jpeg',
//       name: 'GA75+',
//       detail: 'This is the detail of product',
//       stock: 0,
//     ),
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/oilfree1.jpg',
//       name: 'Oil Free',
//       detail: 'This is the detail of product',
//       stock: 23,
//     ),
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/Screws.jpeg',
//       name: 'Screws',
//       detail: 'This is the detail of product',
//       stock: 100,
//     ),
//     Product(
//       assetName:
//           '/Users/kasidito/Documents/IS767/help_me_store/images/VSD5.jpg',
//       name: 'VSD5',
//       detail: 'This is the detail of product',
//       stock: 1,
//     ),
//     // Add more products as needed
//   ];

//   List<Product> get allProducts => products;
// }

// class ViewStock extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productListProvider = Provider.of<ProductListProvider>(context);
//     final products = productListProvider.allProducts;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text('View Stock'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             final product = products[index];
//             return Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(10)),
//                       child: Image.asset(
//                         product.assetName,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.name,
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           product.detail,
//                           style: Theme.of(context).textTheme.bodySmall,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Stock: ${product.stock}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color:
//                                 product.stock > 0 ? Colors.green : Colors.red,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 8.0,
//             childAspectRatio: 0.8,
//           ),
//         ),
//       ),
//     );
//   }
// }
