// product_info.dart

import 'package:flutter/material.dart';

import '../regionscreen/class.dart';

class ProductInfo extends StatelessWidget {
  final Product productnew;

  ProductInfo({required this.productnew});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productnew.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product details here
            Text(
              productnew.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Price: \$${productnew.price.toString()}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
