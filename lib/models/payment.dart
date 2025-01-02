class Payment {
  final String id;
  final String userId;
  final String productId;
  final double amount;
  final String paymentDate;
  final String periodFilter; // Period filter property

  Payment({
    required this.id,
    required this.userId,
    required this.productId,
    required this.amount,
    required this.paymentDate,
    required this.periodFilter, // Include periodFilter in constructor
  });

  // Convert JSON to Payment object
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      amount: json['amount'].toDouble(),
      paymentDate: json['paymentDate'],
      periodFilter: json['periodFilter'] ?? 'Month', // Default to 'Month' if not present in JSON
    );
  }

  // Convert Payment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'amount': amount,
      'paymentDate': paymentDate,
      'periodFilter': periodFilter, // Include periodFilter in JSON
    };
  }
}
