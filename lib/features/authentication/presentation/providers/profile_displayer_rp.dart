import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/authentication/models/user_model.dart';
import 'package:recipe_app/features/authentication/presentation/providers/authentication_provider.dart';

import '../../../../di/getit_setup.dart';
import '../../repository/auth_repository.dart';

AutoDisposeFutureProvider<UserModel> profileInformationProvider =
    FutureProvider.autoDispose((ref) async {
  AsyncLoading();
  final result = ref.watch(authenticationProvider);
  if (result is AsyncData && result.value?.data != null) {
    final authRepo = sl.get<AuthRepository>();
    final user = await authRepo.userProfile();
    return user;
  }

  throw AppGlobalException("You are not logged in");
});
