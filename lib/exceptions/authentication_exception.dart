import 'package:recipe_app/enums/authentication_exceptions_enums.dart';

class AuthenticationException implements Exception {
  final AuthenticationExceptionsEnums error;
  final String? message;

  AuthenticationException(this.message, {required this.error});
}
