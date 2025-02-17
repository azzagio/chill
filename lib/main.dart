import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../models/user_model.dart';
import '../screens/auth_wrapper.dart';
import '../services/auth_services.dart';
import '../services/database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
final _router = GoRouter(
  routes: [
     GoRoute(
      path: '/',
      builder: (context, state) => const AuthWrapper(),
    ),
     GoRoute(
      path: '/login',
      builder: (context, state) =>  LoginScreen(),
    ),
     GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
     GoRoute(
      path: '/profile', 
      builder: (context, state) =>  ProfileScreen(),
    ),
    
  ],
);

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();
  final DatabaseService _dbService = DatabaseService();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: _authService.authStateChanges.asyncMap((user) async {
            if (user == null) {
              return null;
            }
            final data = await _dbService.getUser(user.uid);
            if (data != null) {
              return data;
            } else {
              final userNew = UserModel(
                id: user.uid,
                name: user.displayName ?? 'User',
              );
              await _dbService.createUser(userNew);
              return userNew;
            }
          }),
          initialData: null,
        ),
      ],
      child: MaterialApp.router(
        title: 'Dating App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        routerConfig: _router,
      ),
    );
  }
}