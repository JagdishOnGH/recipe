import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:recipe_app/routes/auto_route_setup.gr.dart';

@RoutePage()
class LoginReminderPage extends ConsumerWidget {
  const LoginReminderPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to continue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You must login first to continue.',
              style: ts.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            50.ht,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  context.pushRoute(LoginRoute());
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
