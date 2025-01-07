import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../../../authentication/presentation/riverpod/authentication_rp.dart';

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  bool isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationRpProvider, (prev, curr) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Checking login status...'))); //snackbar saying checking login status

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
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.replaceRoute((EntryPointRoute()));
          }
        }
      }
    });
    final theme = Theme.of(context);
    final ts = theme.textTheme;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.network(
                width: 400,
                fit: BoxFit.cover,
                "https://static.vecteezy.com/system/resources/previews/036/499/568/non_2x/snack-mini-pizza-with-sausages-tomato-and-cheese-on-a-wooden-board-top-and-vertical-view-photo.jpg"),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: 350,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(),
              10.ht,
              Text(
                'Welcome to Recipe App',
                style: ts.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              6.ht,
              // Text(
              //   ' "Discover the best recipes from around the world" ',
              //   style: ts.bodyMedium?.copyWith(
              //       color: theme.primaryColor,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w600),
              // ),
              Text(
                'Whisk, Bake, Savor – Your Culinary Adventure Starts Now! ',
                style: ts.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              60.ht,
              //demo outline button

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    ref.invalidate(authenticationRpProvider);
                    //ref.read(authenticationRpProvider.notifier).build();
                    context.router.push(
                      LoginRoute(),
                    );
                    // context.pushRoute(LoginRoute());
                  },
                  child: Text('Login to continue'),
                ),
              ),

              10.ht,
              Divider(),
              10.ht,
              //continue as a guest
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    context.router.push(HomeRoute());
                  },
                  child: Text('Continue as a Guest'),
                ),
              ),
            ]))
      ],
    ));
  }
}
