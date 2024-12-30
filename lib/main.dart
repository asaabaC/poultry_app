import 'package:flutter/material.dart';
import 'screens/signUp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart';
import 'screens/product_page.dart';
import 'screens/payment_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/farmer_product_management.dart';
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
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductPage(
            userType: args?['userType'] as String? ?? 'Retailer',
          );
        },
        '/farmer/products': (context) => const FarmerProductManagement(),
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProfileScreen(
            userName: args?['userName'] as String? ?? 'Guest User',
            userEmail: args?['userEmail'] as String? ?? 'guest@example.com',
            profileImage: args?['profileImage'] as String? ?? 'assets/logo.jpg',
          );
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/payment') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => PaymentScreen(
              products: args['products'] as List<Product>,
              orderType: args['orderType'] as String,
              deliveryPreference: args['deliveryPreference'] as String,
              buyerType: args['buyerType'] as String,
            ),
          );
        }
        return null;
      },
    );
  }
}
