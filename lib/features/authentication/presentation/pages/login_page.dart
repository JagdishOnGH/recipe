import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../../../extensions/riverpod_builder.dart';
import '../../../online_recipe/presentation/riverpod/present_recipe_rp.dart';

final logger = Logger();

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ThemeData theme;
  late TextTheme ts;
  late TextEditingController _usernameController;

  late TextEditingController _passwordController;
  bool isDialogOpen = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      theme = Theme.of(context);
      ts = theme.textTheme;
    });

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ts = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 10),
          children: [
            Text(
              'Hello,',
              style: ts.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            10.ht,
            Text("Welcome Back !", style: ts.titleLarge),
            100.ht,
            TextField(
              controller: _usernameController,
              enableSuggestions: true,
              decoration: const InputDecoration(
                hintText: 'Enter Username',
                labelText: 'Username',
                border: const OutlineInputBorder(),
              ),
            ),
            30.ht,
            RiverpodBuilder(builder: (context, ref) {
              final passHideShow = ref.watch(passwordHideShowProvider);
              return TextField(
                controller: _passwordController,
                obscureText: passHideShow,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        passHideShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      ref.read(passwordHideShowProvider.notifier).state =
                          !passHideShow;
                    },
                  ),
                ),
              );
            }),
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
              child: RiverpodBuilder(builder: (context, ref) {
                return FilledButton(
                  onPressed: () {},
                  child: const Text('Login'),
                );
              }),
            ),
            20.ht,
            Divider(),
            20.ht,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                RiverpodBuilder(builder: (context, ref) {
                  return TextButton(
                    onPressed: () {
                      ref.invalidate(onlineRecipeAsyncProvider);
                    },
                    child: const Text('Sign Up'),
                  );
                }),
              ],
            ),
          ],
        ));
  }
}

AutoDisposeStateProvider<bool> passwordHideShowProvider =
    StateProvider.autoDispose((ref) => true);
