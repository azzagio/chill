import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController(); // Ajout d'un contrôleur pour photoUrl
  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserModel>();
    _nameController.text = user.name;
    _bioController.text = user.bio ?? '';
    _photoUrlController.text = user.photoUrl; // Initialisation avec la photoURL existante
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _photoUrlController.dispose(); // Libération du contrôleur photoUrl
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final user = context.read<UserModel>();
    final updatedUser = UserModel(
      id: user.id,
      name: _nameController.text,
      bio: _bioController.text,
      photoUrl: _photoUrlController.text, // Utilisation du contrôleur pour photoUrl
    );
    await _dbService.createUser(updatedUser);
  }

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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            TextField(
              controller: _photoUrlController, // Champ pour photoUrl
              decoration: const InputDecoration(labelText: 'Photo URL'),
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
