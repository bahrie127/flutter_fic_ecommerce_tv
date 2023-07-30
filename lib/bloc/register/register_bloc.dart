import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/register_request_model.dart';
import 'package:flutter_fic6_ecommerce_tv/data/models/responses/auth_response_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.register(event.model);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
