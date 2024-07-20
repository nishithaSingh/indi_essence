import 'package:flutter/material.dart';
import 'package:indi_essence/screens/profilescreen/myorders.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _shippingAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/profileface.jpeg'),
              // You can add a user profile picture here
              // backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nishitha',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'nishithasingh777@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.0),
            buildListTile(Icons.shopping_cart, 'My Orders', () {
              // Handle navigation to My Orders screen
              navigateToScreen('My Orders', MyOrdersScreen());
            }),
            buildListTile(Icons.payment, 'Payment Methods', () {
              // Handle navigation to Payment Methods screen
              navigateToScreen('Payment Methods');
            }),
            buildListTile(Icons.location_on, 'Shipping Address', () {
              // Handle navigation to Shipping Address screen with address input
              navigateToShippingAddressScreen();
            }),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void navigateToScreen(String screen, [Widget? widget]) {
    // Perform navigation to the specified screen
    if (widget != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    }

    print('Navigating to $screen screen');
  }

  void navigateToShippingAddressScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Shipping Address'),
          content: TextField(
            controller: _shippingAddressController,
            decoration: InputDecoration(labelText: 'Shipping Address'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle saving the shipping address or navigating to another screen
                print('Shipping Address: ${_shippingAddressController.text}');
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
