import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/match_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Match operations
  Future<void> createMatch(MatchModel match) async {
    await _firestore.collection('matches').doc('${match.userId1}-${match.userId2}').set(match.toMap());
  }

  Future<MatchModel?> getMatch(String userId1, String userId2) async {
    final doc = await _firestore.collection('matches').doc('$userId1-$userId2').get();
    if (doc.exists) {
      return MatchModel.fromMap(doc.data()!);
    }
    return null;
  }

  Stream<List<UserModel>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<MatchModel>> getMatchesStream(String userId) {
    return _firestore.collection('matches').where('userId1', isEqualTo: userId).where('isMatch', isEqualTo: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MatchModel.fromMap(doc.data())).toList();
    });
  }
}
