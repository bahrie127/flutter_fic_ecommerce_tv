import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/order/order_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/common/snap_widget.dart';
import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/order_request_model.dart';

import '../../bloc/checkout/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Page')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alamat Pengiriman'),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                  labelText: '', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Item Product'),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  final uniqueItem = state.items.toSet().length;
                  final dataSet = state.items.toSet();
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final count = state.items
                            .where(
                              (element) =>
                                  element.id == dataSet.elementAt(index).id,
                            )
                            .length;
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  dataSet.elementAt(index).attributes!.image!)),
                          title: Text(
                            dataSet.elementAt(index).attributes!.name!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Text('$count'),
                        );
                      },
                      itemCount: uniqueItem,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.red,
                        child: const Text('ok'),
                      );
                    },
                    itemCount: 0,
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (model) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SnapWidget(url: model.redirectUrl);
                }));
              },
            );
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEE4D2D)),
                  onPressed: () async {
                    final userId = await AuthLocalDatasource().getUserId();
                    final total = state.items
                        .fold(0, (sum, item) => sum + item.attributes!.price!);
                    final data = Data(
                      items: state.items
                          .map((e) => Item(
                              id: e.id!,
                              productName: e.attributes!.name!,
                              price: e.attributes!.price!,
                              qty: 1))
                          .toList(),
                      totalPrice: total,
                      deliveryAddress: addressController.text,
                      courierName: 'JNE',
                      shippingCost: 22000,
                      statusOrder: 'waitingPayment',
                      userId: userId,
                    );
                    final requestModel = OrderRequestModel(data: data);
                    context
                        .read<OrderBloc>()
                        .add(OrderEvent.doOrder(requestModel));
                  },
                  child: const Text(
                    'Bayar',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
