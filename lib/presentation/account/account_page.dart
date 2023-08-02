import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/list_order/list_order_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/auth/auth_page.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../common/global_variables.dart';
import '../../data/models/responses/auth_response_model.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _page = 1;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  User? user;

  @override
  void initState() {
    getUser();
    context.read<ListOrderBloc>().add(const ListOrderEvent.get());
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
            ),
            title: const Text(
              'Account',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      body: Column(
        children: [
          Text('Nama: ${user != null ? user!.username : '-'}'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //     onPressed: () {}, child: const Text('List Order')),
                ElevatedButton(
                    onPressed: () async {
                      await AuthLocalDatasource().removeAuthData();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AuthPage();
                      }));
                    },
                    child: const Text('Logout')),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 2,
            height: 1,
          ),
          const Text('List Order'),
          Expanded(child: BlocBuilder<ListOrderBloc, ListOrderState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: Text('No Orders'),
                  );
                },
                loaded: (data) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final order = data.data![index];
                      return Card(
                        elevation: 5,
                        shadowColor: const Color(0xffEE4D2D),
                        child: ListTile(
                          title: Text('Order#${order.id}'),
                          subtitle: Text('${order.attributes!.totalPrice}'),
                        ),
                      );
                    },
                    itemCount: data.data!.length,
                  );
                },
              );
            },
          ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AccountPage();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CartPage();
                            },
                          ),
                        );
                      },
                      child: badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            elevation: 0, badgeColor: Colors.white),
                        // elevation: 0,
                        badgeContent: Text(
                          '${state.items.length}',
                          style: const TextStyle(color: Color(0xffEE4D2D)),
                        ),
                        // badgeColor: Colors.white,
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                        ),
                      ),
                    );
                  }
                  return const badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                        elevation: 0, badgeColor: Colors.white),
                    // elevation: 0,
                    badgeContent: Text(
                      '4',
                      style: TextStyle(color: Color(0xffEE4D2D)),
                    ),
                    // badgeColor: Colors.white,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  );
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
