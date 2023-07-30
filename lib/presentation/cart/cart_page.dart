import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/auth/auth_page.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/checkout/checkout_page.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../common/global_variables.dart';
import '../account/account_page.dart';
import '../home/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int page = 2;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Ecommerce',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Subtotal ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutLoaded) {
                      final total = state.items.fold(
                          0, (sum, item) => sum + item.attributes!.price!);
                      return Text(
                        'Rp $total',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return const Text(
                      'calculate',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final isLogin = await AuthLocalDatasource().isLogin();
                if (isLogin) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckoutPage();
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AuthPage();
                  }));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xffEE4D2D),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                final uniqueItem = state.items.toSet().length;
                final dataSet = state.items.toSet();
                return Expanded(
                  child: ListView.builder(
                    itemCount: uniqueItem,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  dataSet.elementAt(index).attributes!.image!,
                                  fit: BoxFit.fitWidth,
                                  height: 135,
                                  width: 135,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 235,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        '${dataSet.elementAt(index).attributes!.name}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      width: 235,
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Text(
                                        'Rp. ${dataSet.elementAt(index).attributes!.price}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      width: 235,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                          '${dataSet.elementAt(index).attributes!.description!.length >= 20 ? dataSet.elementAt(index).attributes!.description!.substring(0, 20) : dataSet.elementAt(index).attributes!.description!}....'),
                                    ),
                                    Container(
                                      width: 235,
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: const Text(
                                        'In Stock',
                                        style: TextStyle(
                                          color: Colors.teal,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<CheckoutBloc>().add(
                                              RemoveFromCartEvent(
                                                  product: dataSet
                                                      .elementAt(index)));
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: BlocBuilder<CheckoutBloc,
                                              CheckoutState>(
                                            builder: (context, state) {
                                              if (state is CheckoutLoaded) {
                                                final countItem = state.items
                                                    .where((element) =>
                                                        element.id ==
                                                        dataSet
                                                            .elementAt(index)
                                                            .id)
                                                    .length;
                                                return Text('$countItem');
                                              }
                                              return const Text('0');
                                            },
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.read<CheckoutBloc>().add(
                                              AddToCartEvent(
                                                  product: dataSet
                                                      .elementAt(index)));
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://picsum.photos/200',
                                fit: BoxFit.contain,
                                height: 135,
                                width: 135,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      'jasjus',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 235,
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: const Text(
                                      'Rp. 200.000',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                        'Eligible for FREE Shipping'),
                                  ),
                                  Container(
                                    width: 235,
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: const Text(
                                      'In Stock',
                                      style: TextStyle(
                                        color: Colors.teal,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black12,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 1.5),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '12',
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.add,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
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
                    color: page == 0
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
                    color: page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return AccountPage();
                  //     },
                  //   ),
                  // );
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AccountPage();
                    }));
                  },
                  child: const Icon(
                    Icons.person_outline_outlined,
                  ),
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
                    color: page == 2
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
