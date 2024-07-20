import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black, // Customizing app bar text color
            fontWeight: FontWeight.bold, // Making app bar text bold
          ),
        ),
        backgroundColor: Colors.white, // Customizing app bar background color
        elevation: 0, // Removing app bar shadow
        iconTheme: IconThemeData(color: Colors.black), // Customizing app bar icon color
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the number of orders
        itemBuilder: (context, index) {
          return Card(
            elevation: 2, // Adding elevation to each order card
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adding margin to each order card
            child: ListTile(
              title: Text(
                'Order ${index + 1}', // Replace with actual order number
                style: TextStyle(fontWeight: FontWeight.bold), // Making order number text bold
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8), // Adding space between order number and details
                  Text(
                    'Total: \50.00', // Replace with actual total amount
                    style: TextStyle(color: Colors.grey[800]), // Customizing total amount text color
                  ),
                  Text(
                    'Status: Delivered', // Replace with actual order status
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold), // Customizing order status text color and weight
                  ),
                  SizedBox(height: 8), // Adding space between details and bottom edge of card
                ],
              ),
              onTap: () {
                // Implement navigation to order details page
              },
            ),
          );
        },
      ),
    );
  }
}