import 'product.dart'; // Import the Product model

/// Represents an order with details about the user, products, total amount, and order date.
class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final double totalAmount;
  final String orderDate;

  /// Constructor for creating an Order object.
  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.orderDate,
  });

  /// Factory constructor to create an Order object from a JSON map.
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((item) => Product.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      orderDate: json['orderDate'] ?? '',
    );
  }

  /// Converts an Order object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
    };
  }
}
