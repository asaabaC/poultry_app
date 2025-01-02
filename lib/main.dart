import 'package:flutter/material.dart';
import 'screens/signUp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart';
import 'screens/product_page.dart';
import 'screens/payment_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/farmer_product_management.dart';
import 'screens/order_screen.dart';
import 'models/product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: '/login', // Default route
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) {
          // Ensure a fallback if arguments are null
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return ProductPage(
            userType: args['userType'] ?? 'Retailer', // Default to 'Retailer'
          );
        },
        '/farmer/products': (context) => const FarmerProductManagement(),
        '/profile': (context) {
          // Ensure a fallback if arguments are null
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return ProfileScreen(
            userName: args['userName'] ?? 'Guest User', // Default userName
            userEmail: args['userEmail'] ?? 'guest@example.com', // Default userEmail
            profileImage: args['profileImage'] ?? 'assets/logo.jpg', // Default profileImage
          );
        },
        '/order': (context) {
          // Ensure a fallback if arguments are null
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return OrderScreen(
            userType: args['userType'] ?? 'Retailer', // Default to 'Retailer'
          );
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/payment') {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => PaymentScreen(
              products: args['products'] as List<Product>? ?? [], // Fallback to an empty list
              orderType: args['orderType'] ?? '', // Fallback to an empty string
              deliveryPreference: args['deliveryPreference'] ?? '', // Fallback to an empty string
              buyerType: args['buyerType'] ?? '', // Fallback to an empty string
            ),
          );
        }
        return null; // Return null for unhandled routes
      },
    );
  }
}
