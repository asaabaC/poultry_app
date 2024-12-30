class Product {
  final String id;
  final String name;
  final double wholesalePrice;
  final double retailPrice;
  final int quantity;
  final int minWholesaleQuantity;
  final bool isAvailable;
  final String description;
  final DateTime lastUpdated;
  final String category;
  final List<String> images;
  final String farmerId;
  final Map<String, dynamic> stockHistory;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.quantity,
    required this.minWholesaleQuantity,
    this.isAvailable = true,
    this.description = '',
    DateTime? lastUpdated,
    this.category = 'Other',
    this.images = const [],
    required this.farmerId,
    this.stockHistory = const {},
    this.rating = 0.0,
    this.reviewCount = 0,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      wholesalePrice: (json['wholesalePrice'] ?? 0.0).toDouble(),
      retailPrice: (json['retailPrice'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      minWholesaleQuantity: json['minWholesaleQuantity'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      description: json['description'] ?? '',
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
      category: json['category'] ?? 'Other',
      images: List<String>.from(json['images'] ?? []),
      farmerId: json['farmerId'] ?? '',
      stockHistory: json['stockHistory'] ?? {},
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wholesalePrice': wholesalePrice,
      'retailPrice': retailPrice,
      'quantity': quantity,
      'minWholesaleQuantity': minWholesaleQuantity,
      'isAvailable': isAvailable,
      'description': description,
      'lastUpdated': lastUpdated.toIso8601String(),
      'category': category,
      'images': images,
      'farmerId': farmerId,
      'stockHistory': stockHistory,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    double? wholesalePrice,
    double? retailPrice,
    int? quantity,
    int? minWholesaleQuantity,
    bool? isAvailable,
    String? description,
    DateTime? lastUpdated,
    String? category,
    List<String>? images,
    String? farmerId,
    Map<String, dynamic>? stockHistory,
    double? rating,
    int? reviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      retailPrice: retailPrice ?? this.retailPrice,
      quantity: quantity ?? this.quantity,
      minWholesaleQuantity: minWholesaleQuantity ?? this.minWholesaleQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      category: category ?? this.category,
      images: images ?? this.images,
      farmerId: farmerId ?? this.farmerId,
      stockHistory: stockHistory ?? this.stockHistory,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}
