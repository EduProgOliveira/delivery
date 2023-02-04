// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:dw9_delivery_appp/app/pages/auth/register/bloc/register_state.dart';
import 'package:dw9_delivery_appp/app/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _repository;

  RegisterController(
    this._repository,
  ) : super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _repository.register(email, name, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } on Exception catch (e, s) {
      log('Erro ao registrar o usuário', error: e, stackTrace: s);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
