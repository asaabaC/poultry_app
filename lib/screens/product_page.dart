import 'package:flutter/material.dart';
import 'payment_screen.dart';

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Layers",
      "type": "Eggs",
      "price": 12000,
      "stock": 50,
      "location": "Kampala",
      "contact": "+256 712 345678",
      "farmer": "John M",
      "profileImage": "assets/_MG_6048.JPG", // Updated
      "gender": "male",
    },
    {
      "name": "Broilers",
      "type": "Broilers",
      "price": 15000,
      "stock": 30,
      "location": "Mukono",
      "contact": "+256 701 234567",
      "farmer": "Grace J",
      "profileImage": "assets/20221011_015355.jpg", // Updated
      "gender": "female",
    },
    {
      "name": "Eggs",
      "type": "Eggs",
      "price": 10000,
      "stock": 100,
      "location": "Entebbe",
      "contact": "+256 772 987654",
      "farmer": "Peter G",
      "profileImage": "assets/logo 5.jpg", // Updated
      "gender": "male",
    },
    {
      "name": "Layers",
      "type": "Eggs",
      "price": 12000,
      "stock": 50,
      "location": "Kampala",
      "contact": "+256 712 345678",
      "farmer": "John W",
      "profileImage": "assets/logo.jpg", // Updated
      "gender": "male",
    },
    {
      "name": "Broilers",
      "type": "Broilers",
      "price": 15000,
      "stock": 30,
      "location": "Mukono",
      "contact": "+256 701 234567",
      "farmer": "Grace",
      "profileImage": "assets/shoes.jpg", // Updated
      "gender": "female",
    },
    {
      "name": "Eggs",
      "type": "Eggs",
      "price": 10000,
      "stock": 100,
      "location": "Entebbe",
      "contact": "+256 772 987654",
      "farmer": "Peter H",
      "profileImage": "assets/w4vzlj.jpg", // Updated
      "gender": "male",
    },
  ];

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poultry Products'),
        centerTitle: true,
        backgroundColor: Colors.orange, // Orange theme color
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product['profileImage'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: UGX ${product['price']} per ${product['type'] == "Eggs" ? 'Tray' : 'Bird'}'),
                  Text('In Stock: ${product['stock']}'),
                  Text('Location: ${product['location']}'),
                  Text('Farmer: ${product['farmer']}'),
                  Text('Type: ${product['type']}'),
                  Text('Gender: ${product['gender']}'),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Buy', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
