import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/product_page.dart';
import 'screens/poultry_management_screen.dart';

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
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => SplashScreen(), // Splash screen
        '/signup': (context) => SignUpScreen(), // Sign-up page
        '/login': (context) => LoginScreen(), // Login page
        '/products': (context) => ProductPage(), // Product page
        '/payment': (context) => const PaymentScreen(), // Payment screen
        '/management': (context) => const PoultryManagementScreen(), // Poultry management
      },
    );
  }
}
