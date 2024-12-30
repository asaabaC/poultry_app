import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderScreen extends StatefulWidget {
  final String userType; // 'farmer', 'wholesaler', or 'retailer'
  
  const OrderScreen({super.key, required this.userType});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Order> orders = [
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
    Order(
      id: 'ORD002',
      userId: 'user1',
      products: [
        Product(
          id: 'p3',
          name: 'Layers',
          wholesalePrice: 30000,
          retailPrice: 33000,
          quantity: 20,
          minWholesaleQuantity: 15,
          description: 'Productive layers, good egg laying rate',
          category: 'Layers',
          farmerId: 'farmer1',
        ),
      ],
      totalAmount: 600000,
      orderDate: '2024-12-29',
      status: 'Confirmed',
      orderType: 'Retail',
      deliveryPreference: 'Pickup',
      paymentStatus: 'Paid',
      buyerType: 'Retailer',
      sellerType: 'Wholesaler',
    ),
  ];

  String _selectedFilter = 'All';
  String _searchQuery = '';
  String _statusFilter = 'All Status';
  String _typeFilter = 'All Types';

  List<Order> get filteredOrders {
    return orders.where((order) {
      // Apply search filter
      bool matchesSearch = order.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          order.products.any((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()));

      // Apply status filter
      bool matchesStatus = _statusFilter == 'All Status' || order.status == _statusFilter;

      // Apply type filter
      bool matchesType = _typeFilter == 'All Types' || order.orderType == _typeFilter;

      // Apply time filter
      bool matchesTimeFilter = true;
      if (_selectedFilter == 'Week') {
        final orderDate = DateTime.parse(order.orderDate);
        final now = DateTime.now();
        matchesTimeFilter = now.difference(orderDate).inDays <= 7;
      } else if (_selectedFilter == 'Month') {
        final orderDate = DateTime.parse(order.orderDate);
        final now = DateTime.now();
        matchesTimeFilter = now.difference(orderDate).inDays <= 30;
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Pending'),
                        selected: _statusFilter == 'Pending',
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = 'Pending';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Confirmed'),
                        selected: _statusFilter == 'Confirmed',
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = 'Confirmed';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('In Transit'),
                        selected: _statusFilter == 'In Transit',
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = 'In Transit';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Delivered'),
                        selected: _statusFilter == 'Delivered',
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = 'Delivered';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All Types'),
                        selected: _typeFilter == 'All Types',
                        onSelected: (selected) {
                          setState(() {
                            _typeFilter = 'All Types';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Wholesale'),
                        selected: _typeFilter == 'Wholesale',
                        onSelected: (selected) {
                          setState(() {
                            _typeFilter = 'Wholesale';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Retail'),
                        selected: _typeFilter == 'Retail',
                        onSelected: (selected) {
                          setState(() {
                            _typeFilter = 'Retail';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order ${order.id}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(order.status)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _getStatusColor(order.status),
                                      ),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: TextStyle(
                                        color: _getStatusColor(order.status),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.orderDate,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    order.orderType,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              ...order.products.map((product) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                'Category: ${product.category}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${product.quantity} x UGX ${NumberFormat('#,###').format(order.orderType == 'Wholesale' ? product.wholesalePrice : product.retailPrice)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'UGX ${NumberFormat('#,###').format((order.orderType == 'Wholesale' ? product.wholesalePrice : product.retailPrice) * product.quantity)}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery: ${order.deliveryPreference}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'Payment: ${order.paymentStatus}',
                                        style: TextStyle(
                                          color: order.paymentStatus == 'Paid'
                                              ? Colors.green
                                              : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'UGX ${NumberFormat('#,###').format(order.totalAmount)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
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
}
