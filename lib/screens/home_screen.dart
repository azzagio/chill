import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  late DatabaseService _dbService;

  @override
  void initState() {
    super.initState();
    _dbService = DatabaseService();  // Initialisation du service de base de données
  }

  @override
  void dispose() {
    controller.dispose(); // Libération des ressources utilisées par le CardSwiperController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserModel?>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: StreamBuilder<List<UserModel>>(
        stream: _dbService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users available.'));
          }

          final users = snapshot.data!;

          return Swiper(
            controller: controller,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(user.profilePicture),
                    const SizedBox(height: 10),
                    Text(user.name, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 5),
                    Text(user.age.toString(),
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );
            },
                  ),
          );
        },
      ),
    );
  }
}
