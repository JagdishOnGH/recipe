import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/authentication/models/user_model.dart';

AutoDisposeFutureProvider<UserModel> profileInformationProvider =
    FutureProvider.autoDispose((ref) async {
  throw AppGlobalException("You are not logged in");
});
