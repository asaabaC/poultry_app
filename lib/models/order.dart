class Order {
  final String id;
  final String userId;
  final List<dynamic> products;
  final double totalAmount;
  final String orderDate;
  final String status;
  final String orderType;
  final String deliveryPreference;
  final String paymentStatus;
  final String buyerType;
  final String sellerType;

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
}