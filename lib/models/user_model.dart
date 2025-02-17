class UserModel {
      String id;
      String name;
      String? photoUrl;
      String? bio;
      List<String>? interests;
      // Add more fields like age, location, etc.

      UserModel({
        required this.id,
        required this.name,
        this.photoUrl,
        this.bio,
        this.interests,
      });

      factory UserModel.fromMap(Map<String, dynamic> map) {
        return UserModel(
          id: map['id'],
          name: map['name'],
          photoUrl: map['photoUrl'],
          bio: map['bio'],
          interests: List<String>.from(map['interests'] ?? []),
        );
      }

      Map<String, dynamic> toMap() {
        return {
          'id': id,
          'name': name,
          'photoUrl': photoUrl,
          'bio': bio,
          'interests': interests,
        };
      }
    }

