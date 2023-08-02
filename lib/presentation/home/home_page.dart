import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/account/account_page.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/cart/cart_page.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/home/widgets/banner_widget.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/home/widgets/list_category_widget.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/home/widgets/list_product_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_fic6_ecommerce_tv/presentation/search/search_page.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../common/global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  final TextEditingController searchController = TextEditingController();
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
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchPage(search: searchController.text);
                        }));
                      },
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
                        hintText: 'Search ',
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          ListCategoryWidget(),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BannerWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'List Product',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(child: ListProductWidget())
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
              child: const Icon(
                Icons.home_outlined,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AccountPage();
                  }));
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
                    return badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                          elevation: 0, badgeColor: Colors.white),
                      // elevation: 0,
                      badgeContent: Text(
                        '${state.items.length}',
                        style: const TextStyle(color: Color(0xffEE4D2D)),
                      ),
                      // badgeColor: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CartPage();
                          }));
                        },
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
                      '0',
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
