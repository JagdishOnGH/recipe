import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../../../authentication/presentation/providers/authentication_provider.dart';

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  bool isDialogOpen = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(authenticationProvider.notifier).localLogin();
      unSkipableLoading(context, "Checking Login Status");
      isDialogOpen = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationProvider, (then, now) {
      print("Now is $now");
      if (now is AsyncError && isDialogOpen) {
        Navigator.of(context).pop();
        isDialogOpen = false;
      } else if (now is AsyncLoading && !isDialogOpen) {
        unSkipableLoading(context, "Loading...");
        isDialogOpen = true;
      } else if (now is AsyncData && isDialogOpen) {
        //snackbar -> Login Success

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Already Logged in")));
        isDialogOpen = false;
        context.router.replace(EntryPointRoute());
      }
    }, onError: (err, st) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("ERR ${err}")));

      print(err);
      print(st);
    });

    final theme = Theme.of(context);
    final ts = theme.textTheme;
    final authState = ref.watch(authenticationProvider);
    authState.when(data: (data) {
      print("I got data");
    }, error: (error, s) {
      print("I got error");
    }, loading: () {
      print("I am loading");
    });
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
                    context.router.push(
                      LoginRoute(),
                    );
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

//unskipable loading with title and circular
//unskipable loading with title and circular
void unSkipableLoading(BuildContext context, String title) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text("$title"),
            ],
          ),
        );
      });
}
