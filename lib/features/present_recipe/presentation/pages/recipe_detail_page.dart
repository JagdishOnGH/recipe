import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:recipe_app/features/present_recipe/presentation/comps/instruction_widgets.dart';

import '../../models/recipe_model.dart';
import 'home_page.dart';

@RoutePage()
class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //persistentFooterButtons: [],
        appBar: AppBar(
          title: Text(recipe.name),
        ),
        body: Column(
          children: [
            SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.fitWidth,
                )),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndInfo(Icons.timer_sharp,
                      recipe.cookTimeMinutes.toString() + ' min'),
                  IconAndInfo(Icons.local_fire_department_outlined,
                      '${recipe.caloriesPerServing} cal'),
                  IconAndInfo(
                      Icons.dinner_dining, '${recipe.servings} Servings'),
                ],
              ),
            ),
            //a big tag text followed chips
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                children: recipe.tags
                    .map((e) => Chip(
                          label: Text(e),
                        ))
                    .toList(),
              ),
            ),
            20.ht,
            TabBar(
              tabs: [
                Tab(
                  text: 'Instructions',
                ),
                Tab(
                  text: 'Ingredients',
                ),
                Tab(
                  text: 'Info',
                ),
              ],
            ),
            Expanded(
              //height: 400,
              child: TabBarView(
                children: [
                  InstructionDisplay(
                    instructions: recipe.instructions,
                    isInstruction: true,
                  ),
                  InstructionDisplay(
                    instructions: recipe.ingredients,
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: Text('Cuisine'),
                        subtitle: Text(recipe.cuisine),
                      ),
                      ListTile(
                        title: Text('Ratings'),
                        subtitle: Text(recipe.rating.toString()),
                      ),
                      ListTile(
                        title: Text('Meal Type'),
                        subtitle: Text(recipe.mealType.join(', ')),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
