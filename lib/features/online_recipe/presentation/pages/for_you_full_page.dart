import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/features/online_recipe/models/recipe_model.dart';
import 'package:recipe_app/features/online_recipe/presentation/components/items_list_comp.dart';

@RoutePage()
class ForYouFullPage extends StatelessWidget {
  final String title;
  final RecipeList _recipeList;

  const ForYouFullPage(this._recipeList, {super.key, this.title = 'For You'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _recipeList.recipes.length,
        itemBuilder: (context, index) {
          final recipe = _recipeList.recipes[index];
          return ItemsGridComp(recipe);
        },
      ),
    );
  }
}
