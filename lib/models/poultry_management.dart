class Poultry {
  final String id;
  final String type; // Example: "Chicken", "Egg", "Feed"
  final int quantity;
  final String dateAdded;

  Poultry({
    required this.id,
    required this.type,
    required this.quantity,
    required this.dateAdded,
  });

  // Convert JSON to Poultry object
  factory Poultry.fromJson(Map<String, dynamic> json) {
    return Poultry(
      id: json['id'],
      type: json['type'],
      quantity: json['quantity'],
      dateAdded: json['dateAdded'],
    );
  }

  // Convert Poultry object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'quantity': quantity,
      'dateAdded': dateAdded,
    };
  }
}
