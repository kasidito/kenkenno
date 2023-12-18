import 'package:flutter/material.dart';

class Product {
  final String imagePath;
  final String name;
  final String detail;
  final int stock;

  Product({
    required this.imagePath,
    required this.name,
    required this.detail,
    required this.stock,
  });
}

class ProductListProvider with ChangeNotifier {
  final List<Product> products = [
    Product(
      imagePath: 'images/ac.jpg',
      name: 'Blower',
      detail: 'This is the detail of product',
      stock: 10,
    ),
    Product(
      imagePath: 'images/ac_G132.png',
      name: 'G132',
      detail: 'This is the detail of product',
      stock: 3,
    ),
    Product(
      imagePath: 'images/AC_ga75(plus).jpeg',
      name: 'GA75+',
      detail: 'This is the detail of product',
      stock: 0,
    ),
    Product(
      imagePath: 'images/ac_oilfree1.jpg',
      name: 'Oil Free',
      detail: 'This is the detail of product',
      stock: 23,
    ),
    Product(
      imagePath: 'images/sp_Screws.jpeg',
      name: 'Screws',
      detail: 'This is the detail of product',
      stock: 100,
    ),
    Product(
      imagePath: 'images/ac_VSD5.jpg',
      name: 'VSD5',
      detail: 'This is the detail of product',
      stock: 1,
    ),
    Product(
      imagePath: 'images/ac_oilfree.jpeg',
      name: 'Oil Free new',
      detail: 'This is the detail of product',
      stock: 3,
    ),
  ];

  List<Product> get allProducts => products;
}
