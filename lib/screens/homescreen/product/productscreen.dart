import 'package:flutter/material.dart';

class ProductGridScreen extends StatelessWidget {
  final List<Product> products = [
    Product('Hand Bag', 'A MYSORE CARVED SANDALWOOD FAN Mysore, Karnataka, Southern India, 19th century', 'assets/mys2.jpeg', 100),
    Product('Shepherd’s Cup Yugoslavia', 'Vintage Large Hand Carved Wood Folk Art Wedding or Shepherd’s Cup Yugoslavia', 'assets/mys13.jpg', 150),
    Product('Product 3', 'Description for Product 3', 'assets/product3.jpg', 200),
    Product('Product 4', 'Description for Product 4', 'assets/product4.jpg', 120),
    Product('Product 5', 'Description for Product 5', 'assets/product5.jpg', 180),
    Product('Product 6', 'Description for Product 6', 'assets/product6.jpg', 90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return ProductItem(product: products[index]);
        },
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

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: TextStyle(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  '${product.price.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 8.0), // Add spacing

                // Add "Try with AR" button
                ElevatedButton(
                  onPressed: () {
                    // Add your action here, e.g., navigate to AR screen
                    // // Navigator.push(
                    // //   context,
                    // //   MaterialPageRoute(
                    // //     builder: (context) => ARScreen(product: product),
                    // //   ),
                    // );
                  },
                  child: Text("Try with AR"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

