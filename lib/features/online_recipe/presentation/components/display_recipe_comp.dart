import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../../models/recipe_model.dart';
import '../pages/home_page.dart';

Widget DisplayRecipeComp(BuildContext context, Recipe recipe) {
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
              !kIsWeb
                  ? CachedNetworkImage(
                      cacheKey: "recipe-image-${recipe.id}",
                      imageUrl: recipe.image,
                      width: 700,
                      height: 400,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Image.asset(
                          "assets/food_placeholder.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    )
                  : Container(
                      height: 400,
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
                                  context.router
                                      .push(RecipeDetailRoute(recipe: recipe));
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
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.favorite_border),
                            //   ),
                            // ),
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
