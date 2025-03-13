import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../routes/auto_route_setup.gr.dart';

class SuggestedCuisineComp extends StatelessWidget {
  final List<String> suggestedCuisine;
  final String image =
      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  SuggestedCuisineComp({super.key, required this.suggestedCuisine}) {
    if (suggestedCuisine.length > 4)
      assert(suggestedCuisine.length > 4,
          "Suggested Cuisine should not be more than 4 items");
  }

  //blue green yellow purple human eye friendly color, also it will have black text
  final List<Color> colors = <Color>[
    Colors.blue.withValues(alpha: 0.9),
    Colors.green.withValues(alpha: 0.9),
    Colors.yellow.withValues(alpha: 0.9),
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: suggestedCuisine.map((e) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              color: colors[suggestedCuisine.indexOf(e)],
              borderRadius: BorderRadius.circular(10)),
          height: 60,
          width: 180,
          child: InkWell(
            onTap: () {
              context.router.push(AllCuisineRoute(cuisineName: e));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$e",
                style: ts.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
