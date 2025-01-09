import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../helper/placeholder_class.dart';
import '../../../../routes/auto_route_setup.gr.dart';
import '../riverpod/authentication_rp.dart';

class LogoutComp extends ConsumerWidget {
  const LogoutComp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchAuthentication = ref.watch(authenticationRpProvider);
    return watchAuthentication.hasValue &&
            (watchAuthentication as AsyncData<DataPlaceHolder>).value.data !=
                null
        ? IconButton(
            onPressed: () {
              ref.read(authenticationRpProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout))
        : IconButton(
            onPressed: () {
              context.router.push(LoginRoute());
            },
            icon: const Icon(Icons.login));
  }
}
