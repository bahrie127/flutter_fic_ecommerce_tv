import 'dart:convert';

class LoginRequestModel {
  final String identifier;
  final String password;
  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'password': password,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      identifier: map['identifier'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) =>
      LoginRequestModel.fromMap(json.decode(source));
}
