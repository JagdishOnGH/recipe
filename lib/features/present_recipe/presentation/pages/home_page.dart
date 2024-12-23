import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../models/recipe_model.dart';
import '../riverpod/present_recipe_rp.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final recipeList = ref.watch(presentRecipeRpProvider);
    return Scaffold(
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Image.network(
                recipe.image,
                width: 400,
                height: 200,
                fit: BoxFit.cover,
              )),
          10.ht,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndInfo(Icons.timer_sharp,
                  recipe.cookTimeMinutes.toString() + ' min'),
              IconAndInfo(Icons.local_fire_department_outlined,
                  '${recipe.caloriesPerServing} cal'),
              IconAndInfo(Icons.dinner_dining, '${recipe.servings} Servings'),
            ],
          ),
          10.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  """${recipe.name}""",
                  style: ts.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              //IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to Favourites')));
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              )
            ],
          ),
          5.ht,
          // 20.ht,
          // SizedBox(
          //     height: 50,
          //     width: double.infinity,
          //     child: OutlinedButton(
          //         onPressed: () {}, child: Text('Start Cooking..')))
        ]));
  }

  Widget IconAndInfo(IconData icon, String text) {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.orange,
            ),
            Text(text)
          ],
        ),
      );
    });
  }
}
