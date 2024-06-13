class UserModel {
  /// create user model class based on json response
  int id;
  String firstName;
  String lastName;
  String email;
  String avatarImg;
  String? role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarImg,
    this.role,
  });

  /// convert json response to user model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatarImg: json['avatar'],
    );
  }
}
