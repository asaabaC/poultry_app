import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart'; // Home Screen after login
import 'screens/product_page.dart';
import 'screens/payment_screen.dart';
import 'screens/poultry_management_screen.dart'; // Admin management screen
import 'screens/order_screen.dart'; // Import order screen

void main() {
  runApp(PoultryApp());
}

class PoultryApp extends StatelessWidget {
  const PoultryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poultry App',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/', // Start with the Splash Screen
      routes: {
        '/': (context) => const SplashScreen(), // Splash Screen route
        '/signup': (context) => const SignUpScreen(), // Sign-up page route
        '/login': (context) => const LoginScreen(), // Login page route
        '/home': (context) => const HomeScreen(), // Home Screen route after login
        '/products': (context) => ProductPage(), // Product page route
        '/payment': (context) => const PaymentScreen(), // Payment screen route
        '/management': (context) => const PoultryManagementScreen(), // Poultry management screen
        '/orders': (context) => OrderScreen(), // Orders screen route
      },
    );
  }
}
