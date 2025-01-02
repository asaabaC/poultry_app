import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderScreen extends StatefulWidget {
  final String userType; // 'farmer', 'wholesaler', or 'retailer'

  const OrderScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Order> orders = [
    // Example orders
    Order(
      id: 'ORD001',
      userId: 'user1',
      products: [
        Product(
          id: 'p1',
          name: 'Broilers',
          wholesalePrice: 25000,
          retailPrice: 28000,
          quantity: 50,
          minWholesaleQuantity: 20,
          description: 'Healthy broilers, ready for sale',
          category: 'Broilers',
          farmerId: 'farmer1',
        ),
        Product(
          id: 'p2',
          name: 'Eggs',
          wholesalePrice: 12000,
          retailPrice: 13500,
          quantity: 100,
          minWholesaleQuantity: 10,
          description: 'Fresh eggs, sold per tray',
          category: 'Eggs',
          farmerId: 'farmer1',
        ),
      ],
      totalAmount: 2450000,
      orderDate: '2024-12-30',
      status: 'Pending',
      orderType: 'Wholesale',
      deliveryPreference: 'Delivery',
      paymentStatus: 'Pending',
      buyerType: 'Wholesaler',
      sellerType: 'Farmer',
    ),
    // Add more orders here if needed
  ];

  String _selectedFilter = 'All';
  String _searchQuery = '';
  String _statusFilter = 'All Status';
  String _typeFilter = 'All Types';

  List<Order> get filteredOrders {
    return orders.where((order) {
      // Apply search filter
      final matchesSearch = order.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          order.products.any((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()));

      // Apply status filter
      final matchesStatus = _statusFilter == 'All Status' || order.status == _statusFilter;

      // Apply type filter
      final matchesType = _typeFilter == 'All Types' || order.orderType == _typeFilter;

      // Apply time filter
      bool matchesTimeFilter = true;
      if (_selectedFilter == 'Week') {
        final orderDate = DateTime.parse(order.orderDate);
        matchesTimeFilter = DateTime.now().difference(orderDate).inDays <= 7;
      } else if (_selectedFilter == 'Month') {
        final orderDate = DateTime.parse(order.orderDate);
        matchesTimeFilter = DateTime.now().difference(orderDate).inDays <= 30;
      }

      return matchesSearch && matchesStatus && matchesType && matchesTimeFilter;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'in transit':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userType == 'farmer' ? 'My Sales' : 'My Orders'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange[50],
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search orders...',
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
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('All Status'),
                      selected: _statusFilter == 'All Status',
                      onSelected: (selected) {
                        setState(() {
                          _statusFilter = 'All Status';
                        });
                      },
                    ),
                    FilterChip(
                      label: const Text('Pending'),
                      selected: _statusFilter == 'Pending',
                      onSelected: (selected) {
                        setState(() {
                          _statusFilter = 'Pending';
                        });
                      },
                    ),
                    FilterChip(
                      label: const Text('Confirmed'),
                      selected: _statusFilter == 'Confirmed',
                      onSelected: (selected) {
                        setState(() {
                          _statusFilter = 'Confirmed';
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(
                    child: Text(
                      'No orders found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text('Order ${order.id}'),
                          subtitle: Text(order.status),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
