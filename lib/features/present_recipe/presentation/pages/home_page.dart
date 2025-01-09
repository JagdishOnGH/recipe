import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/extensions/on_context.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../extensions/error_widget.dart';
import '../../../authentication/presentation/riverpod/authentication_rp.dart';
import '../components/display_recipe_comp.dart';
import '../riverpod/present_recipe_rp.dart';

part '../components/icon_info_comp.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final recipeList = ref.watch(presentRecipeRpProvider);
    final watchAuthentication = ref.watch(authenticationRpProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          actions: [
            IconButton(
                onPressed: () {
                  context.showSnackBar(
                      "Height is ${context.height} and Width is ${context.width}");
                  // context.router.push(SearchRecipeRoute());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: recipeList.when(
            skipLoadingOnReload: false,
            data: (data) {
              if (!data.hasData) return Text("No Data Found");
              final actualData = data.data!;
              return ListView.builder(
                  itemCount: actualData.recipes.length,
                  itemBuilder: (context, index) {
                    return DisplayRecipeComp(
                        context, actualData.recipes[index]);
                  });
            },
            error: (e, s) => CustomErrorWidget(
                  message: (e as AppGlobalException).message,
                  onRetry: () {
                    ref.invalidate(presentRecipeRpProvider);
                  },
                ),
            loading: () {
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(10),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/food_placeholder.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                          30.ht,
                          SizedBox(
                            height: 20,
                            width: 300,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          10.ht,
                          SizedBox(
                            height: 20,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          20.ht,
                        ],
                      ),
                    );
                  });
            }));
  }
}
