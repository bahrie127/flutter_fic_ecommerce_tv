import 'dart:convert';

class OrderResponseModel {
  final String token;
  final String redirectUrl;
  OrderResponseModel({
    required this.token,
    required this.redirectUrl,
  });

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      token: map['token'] ?? '',
      redirectUrl: map['redirect_url'] ?? '',
    );
  }

  factory OrderResponseModel.fromJson(String source) =>
      OrderResponseModel.fromMap(json.decode(source));
}
