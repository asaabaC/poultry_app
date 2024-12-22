import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poultry App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/chicken-farm-banner-with-white-chicken-cartoon-character_1308-90659.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Welcome to Poultry App! 🐔\nWe are committed to providing you with the best poultry products and services, ensuring your success and growth in the poultry industry. Let's grow together!",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(14.0),
              crossAxisSpacing: 14.0,
              mainAxisSpacing: 14.0,
              children: [
                ServiceIcon(
                  icon: Icons.shopping_bag,
                  label: 'Products',
                  onTap: () {
                    Navigator.pushNamed(context, '/products');
                  },
                ),
                ServiceIcon(
                  icon: Icons.list_alt,
                  label: 'Orders',
                  onTap: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                ),
                ServiceIcon(
                  icon: Icons.payment,
                  label: 'Payments',
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
                ServiceIcon(
                  icon: Icons.settings,
                  label: 'Management',
                  onTap: () {
                    Navigator.pushNamed(context, '/management');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ServiceIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100, // Smaller width
        height: 100, // Smaller height
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1],
          ),
          borderRadius: BorderRadius.circular(16.0), // Rounder corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0, color: Colors.white), // White icon
              const SizedBox(height: 8.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for contrast
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final String profileImage = 'assets/profile_picture.jpg'; // Add your default profile picture path here
  final String fullName = 'liz joy';
  final String username = 'liz_joy123';
  final String accountType = 'Farmer'; // Can be dynamic (e.g., Farmer, Retailer, Wholesaler)
  final String email = 'johndoe@example.com';
  final String phone = '+1234567890';

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage(profileImage), // Display profile picture
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Full Name: $fullName',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Username: $username',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Account Type: $accountType',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
