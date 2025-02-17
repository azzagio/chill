import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  String _enteredMessage = '';

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    if (_enteredMessage.trim().isEmpty) {
      return; // Don't submit empty messages
    }
    
    FocusScope.of(context).unfocus(); // Close the keyboard
    _messageController.clear(); // Clear the text field

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    if (!mounted) return;

    setState(() {
      if(_enteredMessage.trim().isNotEmpty){
        FirebaseFirestore.instance.collection('chat').add({
          'text': _enteredMessage,
          'createdAt': Timestamp.now(),
          'userId': userData.id,
          'username': userData.data()!['username'],
          'userImage': userData.data()!['image_url'],
        });
      }
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitMessage,
            icon: const Icon(
              Icons.send
            ),
          ),
        ],
      ),
    );
  }
}
