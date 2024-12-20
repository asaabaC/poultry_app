class Poultry {
  final String id;
  final String type; // Example: "Chicken", "Egg", "Feed"
  final int quantity;
  final String dateAdded;
  final String orderType; // New field for order type

  Poultry({
    required this.id,
    required this.type,
    required this.quantity,
    required this.dateAdded,
    required this.orderType, // New parameter
  });

  // Convert JSON to Poultry object
  factory Poultry.fromJson(Map<String, dynamic> json) {
    return Poultry(
      id: json['id'],
      type: json['type'],
      quantity: json['quantity'],
      dateAdded: json['dateAdded'],
      orderType: json['orderType'], // New field
    );
  }

  // Convert Poultry object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'quantity': quantity,
      'dateAdded': dateAdded,
      'orderType': orderType, // New field
    };
  }
}
