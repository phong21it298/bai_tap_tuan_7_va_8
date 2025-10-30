import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bai_10/auth_service.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  final User user;
  final AuthService _authService = AuthService();

  HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in as: ${user.email}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
