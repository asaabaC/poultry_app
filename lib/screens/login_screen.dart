import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUp_screen.dart';  
import 'product_page.dart';  // Assuming this is the page after login

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  // Load saved credentials (if any)
  void _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  // Save credentials if 'Remember Me' is checked
  void _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('email', _emailController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setBool('rememberMe', _rememberMe);
    } else {
      prefs.remove('email');
      prefs.remove('password');
      prefs.remove('rememberMe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo
            Image.asset(
              'assets/chicken-farm-banner-with-white-chicken-cartoon-character_1308-90659.jpg',
              height: 150, // Adjust the size as needed
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            // Password TextField
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            // Remember Me Checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                const Text('Remember Me'),
              ],
            ),
            const SizedBox(height: 20),
            // Login Button
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            // Sign Up Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  // Handle login logic
  void _handleLogin() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _saveCredentials(); // Save credentials if 'Remember Me' is checked

      // Simulate successful login (you should replace this with real authentication)
      bool loginSuccess = await _authenticateUser();

      if (loginSuccess) {
        // Navigate to the Product Page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductPage()), // Corrected the page name here
        );
      } else {
        // Show error if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  // Simulate user authentication (replace this with your real authentication logic)
  Future<bool> _authenticateUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Debugging print statements
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    
    // Check if credentials match
    bool isAuthenticated = _emailController.text == 'asaaba@gmail.com' && _passwordController.text == '1234';
    print('Authentication result: $isAuthenticated');
    
    return isAuthenticated;
  }
}
