import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../helper/placeholder_class.dart';
import '../../../../routes/auto_route_setup.gr.dart';
import '../../../authentication/presentation/riverpod/authentication_rp.dart';
import '../../models/recipe_model.dart';
import '../riverpod/present_recipe_rp.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final router = AutoRouter.of(context);
    final recipeList = ref.watch(presentRecipeRpProvider);
    final watchAuthentication = ref.watch(authenticationRpProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          actions: [
            watchAuthentication.hasValue &&
                    (watchAuthentication as AsyncData<DataPlaceHolder>)
                            .value
                            .data !=
                        null
                ? IconButton(
                    onPressed: () {
                      ref.read(authenticationRpProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout))
                : IconButton(
                    onPressed: () {
                      context.router.push(LoginRoute());
                    },
                    icon: const Icon(Icons.login)),
            IconButton(
                onPressed: () {
                  context.router.navigate(SearchRecipeRoute());
                  // context.router.push(SearchRecipeRoute());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SafeArea(
            child: recipeList.when(
                data: (data) {
                  if (!data.hasData) return Text("No Data Found");
                  final actualData = data.data!;
                  return ListView.builder(
                      itemCount: actualData.recipes.length,
                      itemBuilder: (context, index) {
                        return DemoWidget(context, actualData.recipes[index]);
                      });
                },
                error: (e, s) => Text(e.toString()),
                loading: () => Center(child: CircularProgressIndicator()))));
  }

  Widget DemoWidget(BuildContext context, Recipe recipe) {
    final theme = Theme.of(context);
    final ts = theme.textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Stack(
              children: [
                Image.network(
                  recipe.image,
                  width: 700,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Container(
                          color: Colors.white.withOpacity(0.8),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.router.push(
                                        RecipeDetailRoute(recipe: recipe));
                                  },
                                  child: Text(
                                    recipe.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: ts.titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.7),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndInfo(
                              Icons.timer_sharp,
                              '${recipe.cookTimeMinutes} min',
                            ),
                            IconAndInfo(
                              Icons.local_fire_department_outlined,
                              '${recipe.caloriesPerServing} cal',
                            ),
                            IconAndInfo(
                              Icons.dinner_dining,
                              '${recipe.servings} Servings',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget IconAndInfo(IconData icon, String text) {
  return Builder(builder: (context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        //   color: Colors.yellow.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          Text(text)
        ],
      ),
    );
  });
}
