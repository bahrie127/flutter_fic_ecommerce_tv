import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/order_request_model.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/responses/list_order_response_model.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    final tokenJwt = await AuthLocalDatasource().getToken();
    print(model.toRawJson());
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjkwNDY2MDQ5LCJleHAiOjE2OTMwNTgwNDl9._IEz7Uqw2p0LiqEkYmcIZLcOzPXdmqjxDhAsKXnFoso'
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }

  Future<Either<String, ListOrderResponseModel>> listOrder() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.get(
      Uri.parse(
          '${GlobalVariables.baseUrl}/api/orders?filters[userId][\$eq]=${authData.user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.jwt}'
      },
    );

    if (response.statusCode == 200) {
      return Right(ListOrderResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('server error');
    }
  }
}


//http://103.150.93.77:1339/api/orders?filter%5BuserId%5D%5B$eq%5D=3
//http://jagoflutter.id/api/orders?filters[userId][$eq]=3