import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart'; // Home Screen after login
import 'screens/product_page.dart';
import 'screens/payment_screen.dart';
import 'screens/poultry_management_screen.dart'; // Admin management screen
import 'screens/order_screen.dart'; // Import order screen
import 'screens/profile_screen.dart'; // Import Profile Screen

void main() {
  runApp(const PoultryApp());
}

class PoultryApp extends StatelessWidget {
  const PoultryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poultry App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/', // Start with the Splash Screen
      routes: {
        '/': (context) => const SplashScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) => ProductPage(),
        '/payment': (context) => const PaymentScreen(),
        '/management': (context) => const PoultryManagementScreen(),
        '/orders': (context) => OrderScreen(),
        '/profile': (context) => const ProfileScreen(), // Profile Screen route
      },
    );
  }
}
