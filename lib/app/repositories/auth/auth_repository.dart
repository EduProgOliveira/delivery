import 'package:dw9_delivery_appp/app/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> register(String email, String name, String password);
  Future<AuthModel> login(String email, String password);
}
