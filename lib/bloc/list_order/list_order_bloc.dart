import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_fic6_ecommerce_tv/data/datasources/order_remote_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/responses/list_order_response_model.dart';

part 'list_order_bloc.freezed.dart';
part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  final OrderRemoteDatasource datasource;
  ListOrderBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.listOrder();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
