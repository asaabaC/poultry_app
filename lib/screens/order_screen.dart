import 'package:flutter/material.dart';
import 'package:poultry_app/models/order.dart';
import 'package:poultry_app/models/product.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  // Constructor for OrderDetailsScreen which requires 'order' as a named parameter
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Order Date: ${order.orderDate}'),
            const SizedBox(height: 8),
            Text('Total Amount: \$${order.totalAmount}'),
            const SizedBox(height: 8),
            const Text(
              'Products:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...order.products.map((product) => _buildProductItem(product)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '${product.name} x${product.quantity} - \$${product.price} each - Location: ${product.location}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class OrderScreen extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '001',
      userId: 'user1',
      products: [
        Product(id: 'p1', name: 'Chicken - Whole', price: 20.0, quantity: 2, location: 'Freezer'),
        Product(id: 'p2', name: 'Eggs (Dozen)', price: 12.0, quantity: 1, location: 'Refrigerator'),
      ],
      totalAmount: 52.0,
      orderDate: '2024-12-21',
    ),
    Order(
      id: '002',
      userId: 'user1',
      products: [
        Product(id: 'p3', name: 'Chicken - Breasts', price: 15.0, quantity: 1, location: 'Freezer'),
      ],
      totalAmount: 15.0,
      orderDate: '2024-12-22',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Order ID: ${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date: ${order.orderDate}'),
                    Text('Total Amount: \$${order.totalAmount}'),
                    const Text('Products:'),
                    ...order.products.map((product) => Text(
                          '${product.name} x${product.quantity} - \$${product.price} each - Location: ${product.location}',
                        )),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to the detailed order screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(order: order),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
