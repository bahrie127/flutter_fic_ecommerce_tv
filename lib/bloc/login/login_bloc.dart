import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_fic6_ecommerce_tv/data/datasources/auth_remote_datasource.dart';

import '../../data/models/login_request_model.dart';
import '../../data/models/responses/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;
  LoginBloc(
    this.datasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold(
        (l) => emit(LoginError()),
        (r) => emit(LoginLoaded(model: r)),
      );
    });
  }
}
