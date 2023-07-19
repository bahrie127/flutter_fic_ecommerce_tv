import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(DetailProductInitial()) {
    on<DetailProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
