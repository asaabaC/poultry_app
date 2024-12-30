import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import 'order_screen.dart';

class ProductPage extends StatefulWidget {
  final String userType;
  const ProductPage({super.key, required this.userType});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Broilers',
      wholesalePrice: 25000.0,
      retailPrice: 28000.0,
      quantity: 100,
      minWholesaleQuantity: 20,
      description: 'Healthy broilers, ready for sale',
      category: 'Broilers',
      farmerId: 'farmer1',
    ),
    Product(
      id: 'p2',
      name: 'Layer Eggs',
      wholesalePrice: 12000.0,
      retailPrice: 13500.0,
      quantity: 500,
      minWholesaleQuantity: 10,
      description: 'Fresh eggs from healthy layers',
      category: 'Eggs',
      farmerId: 'farmer1',
    ),
    Product(
      id: 'p3',
      name: 'Layers',
      wholesalePrice: 30000.0,
      retailPrice: 33000.0,
      quantity: 50,
      minWholesaleQuantity: 15,
      description: 'Productive layers with good egg laying rate',
      category: 'Layers',
      farmerId: 'farmer2',
    ),
    Product(
      id: 'p4',
      name: 'Chicken Feed',
      wholesalePrice: 150000.0,
      retailPrice: 165000.0,
      quantity: 200,
      minWholesaleQuantity: 5,
      description: 'High quality chicken feed, 50kg bags',
      category: 'Feed',
      farmerId: 'farmer2',
    ),
  ];

  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Broilers',
    'Layers',
    'Eggs',
    'Feed',
    'Chicks'
  ];

  List<Product> get filteredProducts {
    return _products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.category,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pricing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildPriceCard(
                  'Retail Price',
                  product.retailPrice,
                  'Per unit/piece',
                  Colors.blue,
                ),
                const SizedBox(height: 8),
                _buildPriceCard(
                  'Wholesale Price',
                  product.wholesalePrice,
                  'Min. quantity: ${product.minWholesaleQuantity} units',
                  Colors.green,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Stock Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildStockIndicator(product.quantity),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (widget.userType.toLowerCase() == 'farmer' ||
                            product.quantity <= 0)
                        ? null
                        : () {
                            Navigator.pushNamed(
                              context,
                              '/payment',
                              arguments: {
                                'products': [product],
                                'orderType': widget.userType.toLowerCase() ==
                                        'wholesaler'
                                    ? 'Wholesale'
                                    : 'Retail',
                                'deliveryPreference': 'Pickup',
                                'buyerType': widget.userType,
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      product.quantity > 0 ? 'Place Order' : 'Out of Stock',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCard(
      String title, double price, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Text(
            'UGX ${NumberFormat('#,###.00').format(price)}',
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockIndicator(int quantity) {
    Color color;
    String status;
    double percentage;

    if (quantity > 100) {
      color = Colors.green;
      status = 'In Stock';
      percentage = 1.0;
    } else if (quantity > 50) {
      color = Colors.orange;
      status = 'Medium Stock';
      percentage = 0.6;
    } else if (quantity > 0) {
      color = Colors.red;
      status = 'Low Stock';
      percentage = 0.3;
    } else {
      color = Colors.grey;
      status = 'Out of Stock';
      percentage = 0.0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$quantity units available',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange[50],
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          backgroundColor:
                              isSelected ? Colors.orange : Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return InkWell(
                        onTap: () => _showProductDetails(context, product),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.orange[100],
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    _getCategoryIcon(product.category),
                                    size: 48,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.category,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'UGX ${NumberFormat('#,###.00').format(widget.userType.toLowerCase() == 'wholesaler' ? product.wholesalePrice : product.retailPrice)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.inventory_2,
                                          size: 16,
                                          color:
                                              _getStockColor(product.quantity),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${product.quantity} available',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStockColor(
                                                product.quantity),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'broilers':
        return Icons.egg_outlined;
      case 'layers':
        return Icons.egg;
      case 'eggs':
        return Icons.egg_alt;
      case 'feed':
        return Icons.grass;
      case 'chicks':
        return Icons.pets;
      default:
        return Icons.category;
    }
  }

  Color _getStockColor(int quantity) {
    if (quantity > 100) return Colors.green;
    if (quantity > 50) return Colors.orange;
    if (quantity > 0) return Colors.red;
    return Colors.grey;
  }
}
