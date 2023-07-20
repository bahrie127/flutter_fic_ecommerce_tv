

part of 'checkout_bloc.dart';



abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  
  List<Product> items;
  
  CheckoutLoaded({
    required this.items,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckoutLoaded &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class CheckoutError extends CheckoutState {}
