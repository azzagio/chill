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
      final DatabaseService _dbService = DatabaseService();

      @override
      void initState() {
        super.initState();
        final user = context.read<UserModel>();
        _nameController.text = user.name;
        _bioController.text = user.bio ?? '';
      }

      @override
      void dispose() {
        _nameController.dispose();
        _bioController.dispose();
        super.dispose();
      }

      Future<void> _saveProfile() async {
        final user = context.read<UserModel>();
        final updatedUser = UserModel(id: user.id, name: _nameController.text, bio: _bioController.text);
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
