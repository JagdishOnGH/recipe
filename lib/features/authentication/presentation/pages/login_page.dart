import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ts = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 10),
          children: [
            Text(
              'Hello,',
              style: ts.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            10.ht,
            Text("Welcome Back !", style: ts.titleLarge),
            100.ht,
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Email',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            30.ht,
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Password',
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            30.ht,
            InkWell(
              onTap: () {},
              child: Text("Forgot Password?",
                  style: ts.bodyMedium?.copyWith(
                      color: theme.primaryColor, fontWeight: FontWeight.bold)),
            ),
            20.ht,
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () {
                  // context.router.push(OnboardingRoute());
                },
                child: Text('Login'),
              ),
            ),
            20.ht,
            Divider(),
            20.ht,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    // context.router.push(OnboardingRoute());
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ));
  }
}
