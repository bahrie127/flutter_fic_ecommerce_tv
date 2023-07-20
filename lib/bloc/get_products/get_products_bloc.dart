import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fic6_ecommerce_tv/data/datasources/product_remote_datasource.dart';

import '../../data/models/responses/list_product_response_model.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductRemoteDatasource datasource;
  GetProductsBloc(
    this.datasource,
  ) : super(GetProductsInitial()) {
    on<DoGetProductsEvent>((event, emit) async {
      emit(GetProductsLoading());
      final result = await datasource.getAllProduct();
      result.fold(
        (l) => emit(GetProductsError()),
        (r) => emit(GetProductsLoaded(data: r)),
      );
    });
  }
}
