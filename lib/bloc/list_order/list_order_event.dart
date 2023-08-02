part of 'list_order_bloc.dart';

@freezed
class ListOrderEvent with _$ListOrderEvent {
  const factory ListOrderEvent.started() = _Started;
  const factory ListOrderEvent.get() = _Get;
}