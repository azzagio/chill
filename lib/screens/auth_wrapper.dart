import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère l'utilisateur actuel à partir du provider
    final currentUser = Provider.of<UserModel?>(context);

    // Si l'utilisateur est authentifié, montre la page d'accueil, sinon la page de connexion
    if (currentUser == null) {
      return const LoginScreen();  // Remplace par ton écran de connexion
    } else {
      return const HomeScreen();  // Remplace par ton écran d'accueil
    }
  }
}
