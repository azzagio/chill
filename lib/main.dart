import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Dating App',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authService.signInWithGoogle();
                  if (!context.mounted) return; // Vérification avant d'utiliser context
                  Navigator.pushReplacementNamed(context, '/home');
                } on FirebaseAuthException catch (e) {
                  if (!context.mounted) return;
                  String errorMessage = 'Login failed.';
                  if (e.code == 'user-not-found') {
                    errorMessage = 'No user found for that email.';
                  } else if (e.code == 'wrong-password') {
                    errorMessage = 'Wrong password provided for that user.';
                  } else if (e.code == 'invalid-credential') {
                    errorMessage = 'Invalid credential';
                  } else {
                    errorMessage = 'Login failed. Code: ${e.code}';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An unexpected error occurred: $e')),
                  );
                }
              },
              child: const Text('Login with Google'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (!context.mounted) return;
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
