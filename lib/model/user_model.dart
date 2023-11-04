class UserModel {
  final String userId;
  final String name;
  final String email;
  final String imageUrl;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  // Create a UserModel instance from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
}