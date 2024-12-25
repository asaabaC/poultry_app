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
          // Wallet AppBar
          Container(
            color: Colors.orangeAccent,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                const Text(
                  'My Wallet',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WalletActionIcon(
                      icon: Icons.send,
                      label: 'Send Money',
                      onTap: () {
                        // Navigate to Send Money Screen
                        Navigator.pushNamed(context, '/send_money');
                      },
                    ),
                    WalletActionIcon(
                      icon: Icons.history,
                      label: 'Transactions',
                      onTap: () {
                        // Navigate to Transactions Screen
                        Navigator.pushNamed(context, '/transactions');
                      },
                    ),
                    WalletActionIcon(
                      icon: Icons.payment,
                      label: 'Pay',
                      onTap: () {
                        // Navigate to Pay Screen
                        Navigator.pushNamed(context, '/pay');
                      },
                    ),
                    WalletActionIcon(
                      icon: Icons.account_balance_wallet,
                      label: 'Deposit Money',
                      onTap: () {
                        // Navigate to Deposit Money Screen
                        Navigator.pushNamed(context, '/deposit_money');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
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

class WalletActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const WalletActionIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              size: 30.0,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
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
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1],
          ),
          borderRadius: BorderRadius.circular(16.0),
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
              Icon(icon, size: 40.0, color: Colors.white),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
