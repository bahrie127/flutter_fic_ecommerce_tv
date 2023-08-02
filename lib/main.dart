import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/list_order/list_order_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/login/login_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/order/order_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/register/register_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/search/search_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/order_remote_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/product_remote_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/home/home_page.dart';

import 'bloc/checkout/checkout_bloc.dart';
import 'bloc/get_products/get_products_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ListOrderBloc(OrderRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
