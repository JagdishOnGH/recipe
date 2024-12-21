import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../routes/auto_route_setup.gr.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FilledButton(
        onPressed: () {
          context.router.push(LoginRoute());
        },
        child: Text('Go to Login'),
      ),
    ));
  }
}
