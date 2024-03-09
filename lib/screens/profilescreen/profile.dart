import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/profileface.jpeg'),
              // You can add a user profile picture here
              // backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              'John Doe',
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
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('My Orders'),
              onTap: () {
                // Handle navigation to My Orders screen
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment Methods'),
              onTap: () {
                // Handle navigation to Payment Methods screen
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Shipping Address'),
              onTap: () {
                // Handle navigation to Shipping Address screen
              },
            ),
            SizedBox(height: 24.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle logout
            //   },
            //   child: Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}


