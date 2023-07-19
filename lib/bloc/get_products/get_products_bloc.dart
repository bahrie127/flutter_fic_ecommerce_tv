import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  GetProductsBloc() : super(GetProductsInitial()) {
    on<GetProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
