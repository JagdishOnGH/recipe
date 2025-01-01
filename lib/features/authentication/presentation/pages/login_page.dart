import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:recipe_app/features/present_recipe/presentation/riverpod/present_recipe_rp.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../riverpod/authentication_rp.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isDialogOpen = false;

  @override
  void initState() {
    ///add [jsa] }
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(authenticationRpProvider.notifier);
    // });

    //  ref.read(authenticationRpProvider.notifier).build();
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
    // final watchAuthentication = ref.watch(authenticationRpProvider);
    final passHideShow = ref.watch(passwordHideShowProvider);
    ref.listen(authenticationRpProvider, (prev, curr) {
      print("prev $prev and curr $curr");
      if (curr is AsyncLoading) {
        isDialogOpen = true;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      10.ht,
                      Text('Please wait...'),
                    ],
                  ),
                ));
      } else if ((prev is AsyncLoading && prev != null) &&
          (curr is AsyncError || curr is AsyncData)) {
        if (isDialogOpen) {
          context.maybePop();
          isDialogOpen = false;
        }
        if (curr is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(curr.error.toString()),
          ));
        }
        if (curr is AsyncData) {
          if ((curr as AsyncData).value.hasData == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Logged in'),
            ));
            context.router.popUntil((route) => route.isFirst);
            context.replaceRoute((EntryPointRoute()));
          }
        }
      }
    });
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
            TextField(
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
                  ref.read(authenticationRpProvider.notifier).login(
                      _usernameController.text, _passwordController.text);
                },
                child: const Text('Login'),
              ),
            ),
            20.ht,
            Divider(),
            20.ht,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    ref.invalidate(presentRecipeRpProvider);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ));
  }
}

AutoDisposeStateProvider<bool> passwordHideShowProvider =
    StateProvider.autoDispose((ref) => true);
