import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key}); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"), // Mark Text widget as const
      ),
      body: const Center( // Mark Center widget as const
        child: Text("Oops! Something went wrong."), // Mark Text widget as const
      ),
    );
  }
}
