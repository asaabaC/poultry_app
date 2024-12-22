class Product {
  final String id;
  final String name; // Product name (e.g., "Chicken", "Eggs")
  final double price; // Product price
  final int quantity; // Product quantity

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  // Factory: Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
