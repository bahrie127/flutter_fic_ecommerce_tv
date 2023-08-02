import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/responses/list_product_response_model.dart';
import 'package:flutter_fic6_ecommerce_tv/presentation/detail_product/detail_product_page.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsError) {
          return const Center(
            child: Text('data error'),
          );
        }
        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text('Data Empty'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final Product product = state.data.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailProductPage(product: product);
                  }));
                },
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xffEE4D2D),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: product.attributes!.image!,
                        child: SizedBox(
                          width: 150,
                          height: 120,
                          child: Image.network(product.attributes!.image!),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        product.attributes!.price!.toString(),
                        style: const TextStyle(
                          color: const Color(0xffEE4D2D),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product.attributes!.name!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CheckoutBloc>().add(
                                          RemoveFromCartEvent(
                                              product: product));
                                    },
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      size: 20,
                                      color: Color(0xffEE4D2D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Text(
                                    "Beli",
                                    style: TextStyle(
                                      color: Color(0xffEE4D2D),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CheckoutBloc>().add(
                                          RemoveFromCartEvent(
                                              product: product));
                                    },
                                    child: const Icon(
                                      Icons.remove_circle_outline,
                                      size: 18,
                                      color: Color(0xffEE4D2D),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: BlocBuilder<CheckoutBloc,
                                        CheckoutState>(
                                      builder: (context, state) {
                                        if (state is CheckoutLoaded) {
                                          final countItem = state.items
                                              .where((element) =>
                                                  element.id == product.id)
                                              .length;
                                          return Text('$countItem');
                                        }
                                        return const Text('0');
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<CheckoutBloc>().add(
                                          AddToCartEvent(product: product));
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      size: 18,
                                      color: Color(0xffEE4D2D),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.data.data!.length,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
