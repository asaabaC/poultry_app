class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String location; // Added location field

  // Constructor for creating a Product object
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.location, // Include location as required
  });

  // Factory constructor to create a Product object from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      location: json['location'] ?? '', // Default empty string if location is missing
    );
  }

  // Converts Product object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'location': location, // Added location field
    };
  }
}
