import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:recipe_app/extensions/riverpod_builder.dart';
import 'package:recipe_app/features/online_recipe/presentation/riverpod/veg_recipe_provider.dart';

import '../../../../extensions/error_widget.dart';
import '../../../../routes/auto_route_setup.gr.dart';
import '../components/items_list_comp.dart';
import '../components/suggested_cuisine_comp.dart';
import '../riverpod/present_recipe_rp.dart';
import 'home_page_shimmer.dart';

part '../components/icon_info_comp.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final ts = Theme.of(context).textTheme;
    final recipeList = ref.watch(onlineRecipeAsyncProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          actions: [
            IconButton(
                onPressed: () {
                  context.router.push(SearchRecipeRoute());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SafeArea(
            child: recipeList.when(
                skipLoadingOnReload: false,
                data: (data) {
                  if (data.data == null) return Text("No Data Found");
                  final recipes = data.data!;
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    children: [
                      Row(),
                      10.ht,
                      Center(
                        child: Text(
                          "Delicious recipes at your fingertips, anytime, anywhere!",
                          style: ts.titleMedium?.copyWith(
                              color: Colors.amber.shade900, fontSize: 13),
                        ),
                      ),
                      20.ht,
                      Divider(),
                      10.ht,
                      SuggestedCuisineComp(
                        suggestedCuisine: [
                          "Spanish",
                          "Indian",
                          "Nepali",
                          "Italian",
                        ],
                      ),
                      20.ht,
                      Center(
                        child: Text(
                            "Do You Know? You can save recipe to view offline"),
                      ),
                      30.ht,
                      Row(
                        children: [
                          Text("For You",
                              style: ts.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 18)),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 1.0),
                            child: InkWell(
                              onTap: () {
                                context.router
                                    .push(ForYouFullRoute(recipeList: recipes));
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      10.ht,
                      SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recipes.recipes.take(5).length,
                          itemBuilder: (context, index) {
                            return ItemsComp(recipes.recipes[index]);
                          },
                        ),
                      ),
                      RiverpodBuilder(
                        builder: (context, ref) {
                          final greenRecipes = ref.watch(vegRecipeProvider);
                          return greenRecipes.when(data: (gRecipes) {
                            final myRecipes =
                                gRecipes.recipes.reversed.toList();
                            return Column(
                              children: [
                                20.ht,
                                Row(
                                  children: [
                                    Text("Vegetarian Recipes 🟢 ",
                                        style: ts.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 18)),
                                    const Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 1.0),
                                      child: InkWell(
                                        onTap: () {
                                          context.router.push(ForYouFullRoute(
                                              title: "Vegetarian Recipes",
                                              recipeList: gRecipes
                                                ..recipes.reversed.toList()));
                                        },
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                10.ht,
                                SizedBox(
                                  height: 190,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: myRecipes.take(5).length,
                                    itemBuilder: (context, index) {
                                      return ItemsComp(myRecipes[index]);
                                    },
                                  ),
                                ),
                              ],
                            );
                          }, error: (error, st) {
                            return CustomErrorWidget(
                              message: (error as AppGlobalException).message,
                              onRetry: () {
                                ref.invalidate(vegRecipeProvider);
                              },
                            );
                          }, loading: () {
                            return RecipeShimmerPage();
                          });
                        },
                      ),
                    ],
                  );
                },
                error: (e, s) => CustomErrorWidget(
                      message: (e as AppGlobalException).message,
                      onRetry: () {
                        ref.invalidate(onlineRecipeAsyncProvider);
                      },
                    ),
                loading: () {
                  return RecipeShimmerPage();
                })));
  }
}
