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
                  // Attempt to log in
                  await authService.login();
                  // Navigation after successful login
                  Navigator.pushReplacementNamed(context, '/home');
                } on FirebaseAuthException catch (e) {
                    String errorMessage = 'Login failed.';
                    if (e.code == 'user-not-found') {
                        errorMessage = 'No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                        errorMessage = 'Wrong password provided for that user.';
                    } else if (e.code == 'invalid-credential'){
                        errorMessage = 'Invalid credential';
                    }
                    else{
                        errorMessage = 'Login failed. code : ${e.code}';
                    }
                    // Display an error if login fails
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                    );
                } catch (e) { // Catch other errors
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An unexpected error occurred: $e')));
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Action pour s'inscrire si l'utilisateur n'a pas de compte
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
