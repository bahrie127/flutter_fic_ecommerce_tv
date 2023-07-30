import 'dart:convert';

class RegisterRequestModel {
//   {
//     "name": "bahri",
//     "password": "123456",
//     "email": "bahri2@gmail.com",
//     "username": "bahri"
// }

  final String name;
  final String password;
  final String email;
  final String username;
  RegisterRequestModel({
    required this.name,
    required this.password,
    required this.email,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'username': username,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source));
}
