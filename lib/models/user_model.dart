class UserModel {
  final String userId;
  final String username;
  final String name;
  final String email;
  final String? profileUrl;
  final String? bio;

  UserModel({
    required this.userId,
    required this.username,
    required this.name,
    required this.email,
    this.profileUrl,
    this.bio
  });

  // Saving data in firestore in firestore format Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
      'bio': bio,
    };
  }

  // Fetching data from firestore in dart format
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
        userId: docId,
        username: map['username'],
        name: map['name'] ?? '',
        email: map['email'],
        profileUrl: map['profileUrl'] ?? '',
        bio: map['bio'] ?? ''
    );
  }
}