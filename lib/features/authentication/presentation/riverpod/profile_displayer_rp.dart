import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/authentication/models/user_model.dart';
import 'package:recipe_app/features/authentication/presentation/riverpod/authentication_rp.dart';
import 'package:recipe_app/features/authentication/repository/auth_repository.dart';
import 'package:recipe_app/helper/placeholder_class.dart';

import '../../../../di/getit_setup.dart';

AutoDisposeFutureProvider<UserModel> profileInformationProvider =
    FutureProvider.autoDispose((ref) async {
  final AsyncValue<DataPlaceHolder<String>> authState =
      ref.watch(authenticationAsyncStateProvider);
  if (authState.hasValue && authState.asData != null) {
    final AuthRepository authRepo = sl();
    AsyncLoading();
    final data = authRepo.userProfile();
    return data;
  }
  throw AppGlobalException("You are not logged in");
});
