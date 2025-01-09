import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:recipe_app/features/present_recipe/presentation/components/items_list_comp.dart';

import '../components/suggested_cuisine_comp.dart';

///USED HARDCODED [COLORS]
@RoutePage()
class HomeNPage2 extends StatelessWidget {
  const HomeNPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            Row(),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: InkWell(
                  child: Icon(Icons.search),
                  onTap: () {},
                ),
              ),
            ),
            20.ht,
            Text(
              "Delicious recipes at your fingertips, anytime, anywhere!",
              style: ts.bodyLarge?.copyWith(color: Colors.amber.shade900),
            ),
            20.ht,
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
              child: Text("Do You Know? You can save recipe to view offline"),
            ),
            30.ht,
            Text("For You",
                style: ts.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18)),
            10.ht,
            Wrap(
              children: [
                ItemsComp(),
                ItemsComp(),
              ],
            )
          ],
        ));
  }
}
