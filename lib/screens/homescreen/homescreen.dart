import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class ListItem {
  final String text;
  final String imagePath;

  ListItem(this.text, this.imagePath);
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ListItem> itemList = [
    ListItem("Karnataka", 'assets/karnataka.jpg'),
    ListItem("Kerala", 'assets/kerala.jpg'),
    ListItem("Haryana", 'assets/haryana.jpg'),
    ListItem("Maharashtra", 'assets/maharashtra.jpg'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // List of Items
          ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/regionscreen');
                },
                child: Container(
                  margin: EdgeInsets.all(8.0), // Add margin for spacing between cards
                  decoration: BoxDecoration(
                    // Background for individual Container
                    color: Colors.white.withOpacity(0.7), // Set your background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: add border radius
                    image: DecorationImage(
                      image: AssetImage(itemList[index].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 220.0, // Adjust the height as needed
                  child: Card(
                    color: Colors.transparent, // Make the card background transparent
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ListTile(
                            title: Text(
                              itemList[index].text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                              ),
                            ),
                            leading: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDropdown(BuildContext context, ListItem selectedItem) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    final offsetY = renderBox.localToGlobal(Offset.zero).dy;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  height: 50.0,
                  child: Row(
                    children: [
                      Image.asset(
                        selectedItem.imagePath,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Item $i',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
