part of 'list_order_bloc.dart';

@freezed
class ListOrderState with _$ListOrderState {
  const factory ListOrderState.initial() = _Initial;
  const factory ListOrderState.loading() = _Loading;
  const factory ListOrderState.loaded(ListOrderResponseModel data) = _Loaded;
  const factory ListOrderState.error() = _Error;
}
