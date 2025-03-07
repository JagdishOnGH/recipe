import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routes/auto_route_setup.gr.dart';

class LogoutComp extends ConsumerWidget {
  const LogoutComp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return IconButton(
        onPressed: () {
          context.router.push(LoginRoute());
        },
        icon: const Icon(Icons.login));
  }
}
