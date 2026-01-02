class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
