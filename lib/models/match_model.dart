class MatchModel {
      String userId1;
      String userId2;
      bool isMatch;

      MatchModel({required this.userId1, required this.userId2, this.isMatch = false});

      factory MatchModel.fromMap(Map<String, dynamic> map) {
        return MatchModel(
          userId1: map['userId1'],
          userId2: map['userId2'],
          isMatch: map['isMatch'] ?? false,
        );
      }

      Map<String, dynamic> toMap() {
        return {
          'userId1': userId1,
          'userId2': userId2,
          'isMatch': isMatch,
        };
      }
    }
