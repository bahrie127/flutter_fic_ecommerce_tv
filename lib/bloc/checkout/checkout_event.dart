part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class AddToCartEvent extends CheckoutEvent {
  final Product product;
  AddToCartEvent({
    required this.product,
  });
}

class RemoveFromCartEvent extends CheckoutEvent {
  final Product product;
  RemoveFromCartEvent({
    required this.product,
  });
}
