import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> items = ['Silk saree', 'hand bag']; // Sample list of items in the cart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // title: Text('Shopping Cart'),
        actions: [
          IconButton(
            onPressed: () {
              // Add logic to navigate to the product screen for adding more items
              // For example:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(onItemAdded: (item) {
                    setState(() {
                      items.add(item);
                    });
                  }),
                ),
              );
            },
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutScreen(items: items)),
          );
        },
        child: Icon(Icons.payment),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final List<String> items;

  CheckoutScreen({required this.items});

  @override
  Widget build(BuildContext context) {
    double totalPrice = items.length * 15.0; // Updated pricing logic

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total Price:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '\$$totalPrice',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(totalPrice: totalPrice)),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final double totalPrice;

  PaymentScreen({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total Amount to Pay:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '\$$totalPrice',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to process payment
                // For example, show payment success message
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Payment Successful'),
                      content: Text('Thank you for your purchase!'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatefulWidget {
  final Function(String) onItemAdded;

  ProductScreen({required this.onItemAdded});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (itemNameController.text.isNotEmpty) {
                  widget.onItemAdded(itemNameController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
