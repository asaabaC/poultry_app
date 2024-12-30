import 'product.dart'; // Import the Product model

/// Represents an order with details about the user, products, total amount, and order date.
class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final double totalAmount;
  final String orderDate;
  final String status;
  final String orderType;
  final String deliveryPreference;
  final String paymentStatus;
  final String buyerType;
  final String sellerType;

  /// Constructor for creating an Order object.
  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.orderType,
    required this.deliveryPreference,
    required this.paymentStatus,
    required this.buyerType,
    required this.sellerType,
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
      status: json['status'] ?? 'Pending',
      orderType: json['orderType'] ?? 'Retail',
      deliveryPreference: json['deliveryPreference'] ?? 'Pickup',
      paymentStatus: json['paymentStatus'] ?? 'Pending',
      buyerType: json['buyerType'] ?? 'Retailer',
      sellerType: json['sellerType'] ?? 'Farmer',
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
      'status': status,
      'orderType': orderType,
      'deliveryPreference': deliveryPreference,
      'paymentStatus': paymentStatus,
      'buyerType': buyerType,
      'sellerType': sellerType,
    };
  }
}
