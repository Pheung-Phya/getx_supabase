class Product {
  final int? id;
  final String name;
  final double price;
  final String description;
  final String image;
  final List<String> sizes;
  final List<String> colors;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.sizes,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'sizes': sizes,
      'colors': colors,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
    );
  }
}
