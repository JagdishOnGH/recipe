import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/extensions/error_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../extensions/riverpod_builder.dart';
import '../components/items_list_comp.dart';
import '../riverpod/recipe_cuisine_provider.dart';

@RoutePage()
class AllCuisinePage extends StatelessWidget {
  final String cuisineName;

  const AllCuisinePage({super.key, required this.cuisineName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cuisine'),
      ),
      body: RiverpodBuilder(
        builder: (context, ref) {
          final cuisineState = ref.watch(recipeCuisineProvider(cuisineName));
          return cuisineState.when(
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: false,
            data: (recipeList) {
              if (recipeList.recipes.isEmpty) {
                return Center(child: Text('No $cuisineName Item Found'));
              }
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: recipeList.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList.recipes[index];
                  return ItemsGridComp(recipe);
                },
              );
            },
            loading: () {
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 6, // Number of shimmer items
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              );
              ;
            },
            error: (error, stack) {
              if (error is AppGlobalException)
                return CustomErrorWidget(
                    message: (error).message,
                    onRetry: () {
                      ref.invalidate(recipeCuisineProvider(cuisineName));
                    });
              return CustomErrorWidget(
                  message: "Something went wrong, $error",
                  onRetry: () {
                    ref.invalidate(recipeCuisineProvider(cuisineName));
                  });
            },
          );
        },
      ),
    );
  }
}
