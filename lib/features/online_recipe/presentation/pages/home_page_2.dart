import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../components/items_list_comp.dart';
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
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
              ),
              enableFeedback: true,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            Row(),
            10.ht,
            Center(
              child: Text(
                "Delicious recipes at your fingertips, anytime, anywhere!",
                style: ts.titleMedium
                    ?.copyWith(color: Colors.amber.shade900, fontSize: 13),
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
              child: Text("Do You Know? You can save recipe to view offline"),
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
                  child: Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                )
              ],
            ),
            10.ht,
            SizedBox(
              height: 195,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ItemsComp(),
                  ItemsComp(),
                  ItemsComp(),
                  ItemsComp(),
                ],
              ),
            ),
            20.ht,
            Row(
              children: [
                Text("Popular Recipes",
                    style: ts.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 18)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                )
              ],
            ),
            10.ht,
            SizedBox(
              height: 210,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ItemsComp(),
                  ItemsComp(),
                  ItemsComp(),
                  ItemsComp(),
                ],
              ),
            ),
          ],
        ));
  }
}
