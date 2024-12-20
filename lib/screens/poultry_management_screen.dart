import 'package:flutter/material.dart';

class PoultryManagementScreen extends StatelessWidget {
  const PoultryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poultry Management'), centerTitle: true),
      body: const Center(
        child: Text(
          'Welcome to Poultry Management Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
