class Region {
  final String name;
  final List<Product> products;

  Region(this.name, this.products);
}

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Product(this.name, this.description, this.imageUrl, this.price);
}
