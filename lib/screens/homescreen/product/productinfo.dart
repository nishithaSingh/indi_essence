// product_info_screen.dart

import 'package:flutter/material.dart';

class ProductInfoScreen extends StatelessWidget {
  final Product product;

  ProductInfoScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              product.description,
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product.price.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Product(this.name, this.description, this.imageUrl, this.price);
}
