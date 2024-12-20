import 'package:flutter/material.dart';
import 'payment_screen.dart';

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    // Original products
    {
      "name": "Layers",
      "image": "assets/hen_151155842_1000.jpg",
      "price": 12000,
      "stock": 50
    },
    {
      "name": "Broilers",
      "image":
          "assets/vertical-closeup-shot-brown-chicken-blurred-background_181624-35804.jpg",
      "price": 15000,
      "stock": 30
    },
    {
      "name": "Eggs",
      "image": "assets/raw-eggs-arrangement_23-2151864112.jpg",
      "price": 10000,
      "stock": 100
    },

    // Duplicated items with updated prices
    {
      "name": "Layers",
      "image": "assets/hen_151155842_1000.jpg",
      "price": 13000,
      "stock": 50
    },
    {
      "name": "Broilers",
      "image":
          "assets/vertical-closeup-shot-brown-chicken-blurred-background_181624-35804.jpg",
      "price": 16000,
      "stock": 30
    },
    {
      "name": "Eggs",
      "image": "assets/raw-eggs-arrangement_23-2151864112.jpg",
      "price": 11000,
      "stock": 100
    },
  ];

  // Removed const constructor
  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poultry Products'), centerTitle: true),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(product['image'],
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: UGX ${product['price']}'),
                  Text('In Stock: ${product['stock']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      // Code to show more details about the product
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(product['name']),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(product['image'],
                                  width: 100, height: 100, fit: BoxFit.cover),
                              const SizedBox(height: 10),
                              Text('Price: UGX ${product['price']}'),
                              Text('Stock Available: ${product['stock']}'),
                              const Text(
                                  'Description: This is a premium product, perfect for poultry farms.'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Buy'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
