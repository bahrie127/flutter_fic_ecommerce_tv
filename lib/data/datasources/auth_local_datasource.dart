import 'dart:convert';

import 'package:flutter_fic6_ecommerce_tv/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<bool> saveAuthData(AuthResponseModel model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final result = await pref.setString('auth', jsonEncode(model.toJson()));
    return result;
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('auth');
  }

  Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));
    return authData.jwt;
  }

  Future<AuthResponseModel> getAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));
    return authData;
  }

  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));
    return authData.user;
  }

  Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));
    return authData.user.id;
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth');
    return authJson != null;
  }
}
