import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the user data passed from the LoginScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String userName = args['name'] ?? 'Guest';
    String userEmail = args['email'] ?? 'No email provided';
    String profileImage = args['profileImage'] ?? 'assets/default_profile_image.png';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display profile image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage), // or NetworkImage if using a URL
            ),
            const SizedBox(height: 20),
            // Display user name and email
            Text(
              'Name: $userName',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
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
