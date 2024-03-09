import 'package:flutter/material.dart';

import '../product/productscreen.dart';

class RegionScreen extends StatefulWidget {
  @override
  State<RegionScreen> createState() => _RegionScreenState();
}

class ListItem {
  final String text;
  final String imagePath;

  ListItem(this.text, this.imagePath);
}

class _RegionScreenState extends State<RegionScreen> {
  final List<ListItem> itemList = [
    ListItem("Mysore", 'assets/mysore.jpeg'),
    ListItem("Channapatna", 'assets/chanpatna.jpeg'),
    ListItem("Gadag", 'assets/gadag.jpeg'),
    ListItem("Hassan", 'assets/hassan.jpeg'),
    ListItem("Koppala", 'assets/koppala.jpeg'),
    ListItem("Vijayapura", 'assets/vijyapura.jpeg'),
    ListItem("Tumkuru", 'assets/tumkur.jpeg'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/navbarscreen');
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: itemList.length,
        separatorBuilder: (context, index) => SizedBox(height: 8.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductGridScreen(),
                ),
              );
            },
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        itemList[index].imagePath,
                        fit: BoxFit.cover,
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.dstATop,
                          ),
                          child: Container(color: Colors.black),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ListTile(
                            title: Text(
                              itemList[index].text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


