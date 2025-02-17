class UserModel {
      String id;
      String name;
      String photoUrl;
      String? bio;
      int? age;
      List<String>? interests;
      // Add more fields like age, location, etc.

      UserModel({
        required this.id,
        required this.name,
        required this.photoUrl,
        this.bio,
        this.age,
        this.interests,
      });

      factory UserModel.fromMap(Map<String, dynamic> map) {
        return UserModel(
          id: map['id'],
          name: map['name'],
          photoUrl: map['photoUrl'],
          bio: map['bio'],
          age: map['age'],
          interests: List<String>.from(map['interests'] ?? []),
        );
      }

      Map<String, dynamic> toMap() {
        return {
          'id': id,
          'name': name,
          'photoUrl': photoUrl,
          'age': age,
          'bio': bio,
          'interests': interests,
        };
      }
    }

