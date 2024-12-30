// profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String profileImage;

  // Constructor to accept parameters
  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display profile image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage),
            ),
            const SizedBox(height: 20),
            // Display username
            Text(
              'Name: $userName',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            // Display email
            Text(
              'Email: $userEmail',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
