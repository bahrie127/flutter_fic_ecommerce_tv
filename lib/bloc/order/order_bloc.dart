import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_fic6_ecommerce_tv/data/datasources/order_remote_datasource.dart';

import '../../data/models/order_request_model.dart';
import '../../data/models/responses/order_response_model.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource datasource;
  OrderBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_DoOrder>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.order(event.model);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
