import 'package:flutter/material.dart';
import 'package:indi_essence/screens/homescreen/product/productinfo.dart';
import '../../arscreens/localAndWebObjectsView.dart';



class ProductGridScreen extends StatefulWidget {
  @override
  _ProductGridScreenState createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  late List<Product> products;
  late List<Product> filteredProducts;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    products = [
      Product('Hand Bag', 'A MYSORE CARVED SANDALWOOD FAN Mysore, Karnataka, Southern India, 19th century', 'assets/mys2.jpeg', 100),
      Product('Shepherd’s Cup Yugoslavia', 'Vintage Large Hand Carved Wood Folk Art Wedding or Shepherd’s Cup Yugoslavia', 'assets/mys13.jpg', 150),
      Product('Silk Sarees', 'The saree is best worn for weddingsand can be matched with a contrast blouse', 'assets/my4.jpeg', 200),
      Product('Mysore Painting', 'Mysore paintings are known for paintings of Hindu gods and goddesses with muted colours, art and attributes. The paintings are ancient traditions of Mysore showing sculpture, dancing, music and feelings of Characters', 'assets/my6.jpeg', 120),
      Product('Mysore Peta', 'Mysore Peta was the traditional turban made of silk and jari, worn by the Kings of Mysuru as a royal Indian culture. The attractive and colourful Mysore Peta now worn on special occasions with traditional dress', 'assets/my7.jpg', 180),
      Product('Mysore Ink', 'Mysore Paints and Varnish Limited company produce indelible ink, owned by the Government of Karnataka and the only company in India authorised to produce indelible ink used in elections, only found In Mysore', 'assets/my8.jpg', 90),
    ];
    filteredProducts = products;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return ProductItem(product: filteredProducts[index]);
              },
            ),
          ),
        ],
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
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProductInfo(productnew: product),
          //   ),
          // );
        },
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
                    '\$${product.price.toString()}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Uncomment the following section to add navigation to AR screen
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const LocalAndWebObjectsView(),
                      //   ),
                      // );
                    },
                    child: Text("Try with AR"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}