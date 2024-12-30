import 'package:flutter/material.dart';

class CustomerListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'name': 'Alice',
      'details': '10 eggs',
      'status': 'Pending',
    },
    {
      'name': 'Bob',
      'details': '5 hens',
      'status': 'Confirmed',
    },
    {
      'name': 'Cathy',
      'details': '20 eggs',
      'status': 'Ordered',
    },
    {
      'name': 'David',
      'details': '15 eggs',
      'status': 'Pending',
    },
    {
      'name': 'Eva',
      'details': '2 hens',
      'status': 'Confirmed',
    },
    // Additional orders...
  ];

  CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Orders'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                order['status'] == 'Pending'
                    ? Icons.hourglass_empty
                    : order['status'] == 'Confirmed'
                        ? Icons.check_circle
                        : Icons.shopping_cart,
                color: order['status'] == 'Pending'
                    ? Colors.red
                    : order['status'] == 'Confirmed'
                        ? Colors.green
                        : Colors.blue,
              ),
              title: Text(order['name']),
              subtitle: Text(order['details']),
              trailing: Text(
                order['status'],
                style: TextStyle(
                  color: order['status'] == 'Pending'
                      ? Colors.red
                      : order['status'] == 'Confirmed'
                          ? Colors.green
                          : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
